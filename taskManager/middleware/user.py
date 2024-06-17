import requests
from fastapi.security import OAuth2PasswordBearer
from fastapi import Depends, HTTPException
from typing_extensions import Annotated
from middleware.redis import RedisHelper
import json

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="./login")

redis = RedisHelper("redis", 6379)

def getUser(token: Annotated[str, Depends(oauth2_scheme)]):
    PossibleResponse = redis.get(token)
    if not PossibleResponse:
        response = requests.get("http://login:5002/getUser",headers = {"Authorization": "Bearer "+token})
        redis.insert(token,json.dumps(response.json()),60)
        if response.status_code != 200:
            return HTTPException(response.status_code, response.json())
        response = response.json()

    else:
        response = json.loads(PossibleResponse)

    
    return response
