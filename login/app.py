from fastapi import FastAPI, Depends

from router.user import router as user_router

import uvicorn

app = FastAPI()

app.include_router(user_router)


@app.get("/")
def read_root():
    return {"Hello": "World"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5002)