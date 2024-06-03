from fastapi import APIRouter, Depends, HTTPException
import sqlite3
from models.task import Task, TaskWithoutContent, TaskStatus
from middleware.user import getUser
from typing_extensions import Annotated

router = APIRouter()

@router.post('/addTask')
async def addTask(task:Task,token:Annotated[dict, Depends(getUser)]):
    con = sqlite3.connect("sqlite.db")
    cur = con.cursor()
    title = task.title
    content = task.content
    if not content:
        return {"status": "failed content is required"}
    username = token['user']
    cur.execute("SELECT * FROM tasks WHERE title = ? AND username = ?", (title, username))
    task = cur.fetchone()
    if task:
        raise HTTPException(400,"task not found")
    cur.execute("INSERT INTO tasks (title, content, username, status) VALUES (?, ?, ?, ?)", (title, content, username, False))
    con.commit() 
    return {"status": "success creating task with title: " + title}

@router.get('/getTasks')
async def getTasks( token:Annotated[dict, Depends(getUser)]):
    con = sqlite3.connect("sqlite.db")
    cur = con.cursor()
    username = token['user']
    cur.execute("SELECT * FROM tasks WHERE username = ?", (username,))
    tasks = cur.fetchall()
    tasks = [{"title": task[0], "content": task[1], "status" : task[3]} for task in tasks]
    return {"tasks": tasks}

@router.delete('/deleteTask')
async def deleteTask(task: TaskWithoutContent, token:Annotated[dict, Depends(getUser)]):
    con = sqlite3.connect("sqlite.db")
    cur = con.cursor()
    username = token['user']
    title = task.title
    cur.execute("SELECT * FROM tasks WHERE title = ? AND username = ?", (title, username,))
    task = cur.fetchone()
    if not task:
        return {"status": "failed task not found"}
    cur.execute("DELETE FROM tasks WHERE title = ? AND username =?", (title,username))
    con.commit()
    return {"status": "success deleting task with title: " + title}

@router.put('/updateTask')
async def updateTask(task: Task,token : Annotated[dict, Depends(getUser)]):
    con = sqlite3.connect("sqlite.db")
    cur = con.cursor()
    username = token['user']
    title = task.title
    content = task.content
    cur.execute("SELECT * FROM tasks WHERE title = ? AND username = ?", (title, username))
    task = cur.fetchone()
    if not task:
        return {"status": "failed task not found"}
    cur.execute("UPDATE tasks SET content = ? WHERE title = ? and username = ?", (content, title,username))
    con.commit()
    return {"status": "success updating task with title: " + title}

@router.put('/updateTask/status')
async def updateTask(task: TaskStatus,token : Annotated[dict, Depends(getUser)]):
    con = sqlite3.connect("sqlite.db")
    cur = con.cursor()
    username = token['user']
    title = task.title
    status = task.status
    cur.execute("SELECT * FROM tasks WHERE title = ? AND username = ?", (title, username))
    task = cur.fetchone()
    if not task:
        raise HTTPException(400,"task not found")
    cur.execute("UPDATE tasks SET status = ? where title = ? AND username = ?", (status, title, username))
    con.commit()
    return {"status": "success updating task with title: " + title}
