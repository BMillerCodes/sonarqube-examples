package service

import model.User
import repository.UserRepository

class UserService {
  private var userCache: scala.collection.mutable.Map[Long, User] = scala.collection.mutable.Map()
  private var lastRefresh: Long = 0
  private val CACHE_TTL = 60000 // 1 minute
  
  private val repository = new UserRepository()
  
  def findById(id: Long): Option[User] = {
    userCache.get(id).orElse {
      val user = repository.findById(id)
      user.foreach(u => userCache.put(id, u))
      user
    }
  }
  
  def findByUsername(username: String): Option[User] = {
    repository.findByUsername(username)
  }
  
  def createUser(username: String, email: String, age: Int): User = {
    val user = User(
      id = System.currentTimeMillis(),
      username = username,
      email = email,
      age = age
    )
    repository.save(user)
    userCache.put(user.id, user)
    user
  }
  
  def updateUser(user: User): User = {
    val updated = repository.update(user)
    userCache.put(updated.id, updated)
    updated
  }
  
  def deleteUser(id: Long): Boolean = {
    userCache.remove(id)
    repository.delete(id)
  }
  
  def getActiveUsers(): List[User] = {
    refreshCacheIfNeeded()
    userCache.values.filter(_.status == User.STATUS_ACTIVE).toList
  }
  
  private def refreshCacheIfNeeded(): Unit = {
    if (System.currentTimeMillis() - lastRefresh > CACHE_TTL) {
      userCache.clear()
      lastRefresh = System.currentTimeMillis()
    }
  }
  
  def clearCache(): Unit = {
    userCache.clear()
    lastRefresh = 0
  }
}

object UserService {
  private var instance: UserService = _
  
  def getInstance(): UserService = {
    if (instance == null) {
      instance = new UserService()
    }
    instance
  }
}
