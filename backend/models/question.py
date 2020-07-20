from pydantic import BaseModel
from models.answer import Answer
from typing import List
from models.author import Author

class Question(BaseModel):
    qId: str = None
    title: str
    description: str
    # answerCount: int = 0
    author: Author = None
    answerList: List[Answer] = []