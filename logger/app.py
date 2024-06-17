from fastapi import FastAPI
from dotenv import load_dotenv

load_dotenv()

from application.log import router as user_router

from create_table import created_table

import uvicorn

try:
    created_table()
except:
    pass
app = FastAPI()

app.include_router(user_router)


@app.get("/")
def read_root():
    return {"Hello": "World"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=5004)