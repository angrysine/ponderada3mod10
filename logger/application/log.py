from fastapi.routing import APIRouter
from application.dto.log import Log
from infra.log import LogRepository
import os
from fastapi import HTTPException
from application.dto.log import Log
from datetime import datetime

username = os.environ["username"]
password = os.environ["password"]
dbname = os.environ["dbname"]
host = os.environ["host"]

router = APIRouter()

repository = LogRepository(username,password,dbname,host)

@router.post("/")
def createLog(log : Log):    

    repository.createLog(log.topic,log.level,log.logTime,log.message, log.source)

    return {"message" : f"created log of severity {log.level} in topic {log.topic} with message {log.message}"}

@router.post("/{topic}")
def getLogsTopic(topic : str, startTime :datetime | None = None, endTime :datetime | None = None, level : str | None = None,source : str | None = None):
    print("topic: " + topic+ " startTime: " + str(startTime) + " endTime: " + str(endTime) + " level: " + str(level) + " source: " + str(source))
    response = repository.getLogsFromTopic(topic, startTime, endTime, source, level)
    logs = []
    if response:
        for log in response:
            logs.append(Log(topic = log[0],level = log[1],logTime = log[2],message = log[3],source = log[4]).dict())
            
        return logs
    else:
        return HTTPException(400,"no logs found for this topic")
    
    


