package repository

import model.User
import java.util.concurrent.ConcurrentHashMap
import scala.collection.JavaConverters._

class UserRepository {
  private val users = new ConcurrentHashMap[Long, User]()
  
  def findById(id: Long): Option[User] = {
    Option(users.get(id))
  }
  
  def findByUsername(username: String): Option[User] = {
    users.values().asScala.find(_.username == username)
  }
  
  def findByEmail(email: String): Option[User] = {
    users.values().asScala.find(_.email == email)
  }
  
  def save(user: User): User = {
    users.put(user.id, user)
    user
  }
  
  def update(user: User): User = {
    users.put(user.id, user)
    user
  }
  
  def delete(id: Long): Boolean = {
    users.remove(id) != null
  }
  
  def findAll(): List[User] = {
    users.values().asScala.toList
  }
  
  def count(): Int = {
    users.size()
  }
  
  def clear(): Unit = {
    users.clear()
  }
}
