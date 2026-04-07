package model

class User(
  var id: Long,
  var username: String,
  var email: String,
  var age: Int
) {
  var status: String = "ACTIVE"
  var lastLogin: Long = System.currentTimeMillis()
  
  def this() = this(0, "", "", 0)
  
  def updateEmail(newEmail: String): Unit = {
    if (!newEmail.contains("@")) {
      throw new IllegalArgumentException("Invalid email format")
    }
    this.email = newEmail
  }
  
  def isAdult: Boolean = age >= 18
  
  override def toString: String = s"User(id=$id, username=$username, email=$email, age=$age, status=$status)"
}

object User {
  val STATUS_ACTIVE = "ACTIVE"
  val STATUS_INACTIVE = "INACTIVE"
  val STATUS_SUSPENDED = "SUSPENDED"
  
  def apply(id: Long, username: String, email: String, age: Int): User = {
    new User(id, username, email, age)
  }
  
  def unapply(user: User): Option[(Long, String, String, Int)] = {
    Some((user.id, user.username, user.email, user.age))
  }
}
