import requests
from fastapi.security import OAuth2PasswordBearer
from fastapi import Depends, HTTPException
from typing_extensions import Annotated

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="./login")

def getUser(token: Annotated[str, Depends(oauth2_scheme)]):
    print(token)
    response = requests.get("http://login:5002/getUser",headers = {"Authorization": "Bearer "+token})
    if response.status_code != 200:
        return HTTPException(response.status_code, response.json)
    json = response.json()
    return json
