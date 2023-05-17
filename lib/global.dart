class SessionData{
  late String encryptedUserId;
  late String encryptedPassword;
  late String encryptedToken;
  late int userId;

}
SessionData? globalSessionData=SessionData();


//Having a clear function is pretty handy
void clearSessionData(){
  globalSessionData = SessionData();
}