from pydantic import BaseModel
from datetime import datetime


class Log(BaseModel):
    topic: str
    level : str
    logTime : datetime
    message : str
    source : str

    def __repr__(self) -> str:
        return f"Log(topic={self.topic}, level={self.level}, logTime={self.logTime}, message={self.message}, source={self.source})"
    



