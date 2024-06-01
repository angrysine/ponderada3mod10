from pydantic import BaseModel


class TaskWithoutContent(BaseModel):
    title: str

class Task(TaskWithoutContent):
   content : str
   
class TaskStatus(TaskWithoutContent):
    status : bool
