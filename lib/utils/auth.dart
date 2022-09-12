Map<String, String> authHeaderForm = {
  'Content-type': 'multipart/form-data',
  'Accept': 'application/json',
};

Map<String, String> authHeaderJson = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

void addToken(String token) {
  authHeaderForm['Authorization'] = "Bearer $token";
  authHeaderJson['Authorization'] = "Bearer $token";
}
