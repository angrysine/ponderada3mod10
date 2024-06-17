from datetime import datetime
from config.postegresSQL import PostegresHelper




class LogRepository():

    def __init__(self,username,password,dbname,host) -> None:
        self.pg  =PostegresHelper(username,password,host,dbname)

    def createLog(self,topic:str,level:str,logTime:str, message: str, source : str):
        self.pg.executeInsert("insert into logs (topic, level, logTime, message, source) values (%s,%s,%s, %s,%s)",(topic,level,logTime,message, source,)) 
    
    def getLogsFromTopic(self,topic:str,startTime: datetime | None, endTime : datetime | None, source : str | None, level: str):

        baseQuery = "select * from logs where topic = %s"

        startTimeQuery = ""
        endTimeQuery = ""
        levelQuery = ""
        sourceQuery = ""
        paremeterList = [topic]

        if startTime:
            startTimeQuery = " and logTime > %s"
            paremeterList.append(startTime)
            
        if endTime:
            endTimeQuery = " and logTime < %s"
            paremeterList.append(endTime)

        if level:
            levelQuery = " and level = %s"
            paremeterList.append(level)

        if source:
            sourceQuery = " and source = %s"
            paremeterList.append(source)

        paremeterTuple = tuple(paremeterList)

        query = baseQuery + startTimeQuery + endTimeQuery + levelQuery + sourceQuery

        print(query)

        response = self.pg.executeSelect(query,paremeterTuple)    

        if response:
            return response
    
        return None
    

        