from datetime import datetime, timedelta
from typing import List
import jwt
from fastapi import Depends, FastAPI, HTTPException, Security
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm, SecurityScopes
from jwt import PyJWTError

from pydantic import BaseModel, ValidationError
from starlette.status import HTTP_401_UNAUTHORIZED
from models.token import Token
from models.user import User, UserInDB
from models.question import Question
from models.answer import Answer
from util import get_current_user, authenticate_user, get_password_hash, create_access_token, get_current_active_user
import json
import config
import uuid

app = FastAPI()

with open('qaDb.json') as data_file:
    qaDb = json.load(data_file)

with open('userDb.json') as data_file:
    userDb = json.load(data_file)


@app.post("/api/login/access-token", response_model=Token)
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()):
    user = authenticate_user(userDb, form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    access_token_expires = timedelta(
        minutes=config.ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return {"access_token": access_token, "token_type": "bearer"}


@app.get("/api/profile")
async def get_profile(current_user: User = Depends(get_current_active_user)):
    return current_user


@app.get("/api/hello")
def hello():
    return {"message": "Vedig"}


@app.post("/api/register")
def register_user(new_user: UserInDB):
    new_user.hashed_password = get_password_hash(new_user.password)
    userDb[new_user.username] = new_user.__dict__
    with open('userDb.json', 'w') as f:
        f.write(json.dumps(userDb, indent=4, sort_keys=True))

    return "SUCCESS"


@app.get("/api/questions")
async def get_questions():
    questionList = []
    for i in qaDb["questions"]:
        questionList.append(
            {"qId": i["qId"], "title": i["title"], "description": i["description"]})
    return questionList


@app.get("/api/questions/{qId}")
async def get_question(qId: str):
    for i in qaDb["questions"]:
        if i["qId"] == qId:
            return {"qId": i["qId"], "title": i["title"], "description": i["description"]}


@app.get("/api/questions/{qId}/answers")
async def get_answers(qId: str):
    for i in qaDb["questions"]:
        if i["qId"] == qId:
            return i["answerList"]


@app.get("/api/questions/{qId}/answers/{aId}")
async def get_answer(qId: str, aId: str):
    for i in qaDb["questions"]:
        if i["qId"] == qId:
            for j in i["answerList"]:
                if j["aId"] == aId:
                    return j


@app.post("/api/questions/add")
def addQuestion(question: Question):
    question.qId = str(uuid.uuid1())
    qaDb["questions"].append(question.__dict__)
    with open('qaDb.json', 'w') as f:
        f.write(json.dumps(qaDb, indent=4, sort_keys=True))
    return True

@app.post("/api/questions/{qId}/answers/add")
def addQuestion(qId: str, answer: Answer):
    answer.aId = str(uuid.uuid1())
    data = answer.__dict__
    data["author"] = answer.author.__dict__
    for question in qaDb["questions"]:
        if question["qId"] == qId:
            question["answerList"].append(data)
    with open('qaDb.json', 'w') as f:
        f.write(json.dumps(qaDb, indent=4, sort_keys=True))
    return True
