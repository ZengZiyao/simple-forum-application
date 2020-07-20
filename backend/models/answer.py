from pydantic import BaseModel
from models.author import Author


class Answer(BaseModel):
    aId: str = None
    description: str = ""
    createdTime: int = None
    updatedTime: int = None
    commentCount: int = None
    voteupCount: int = None
    author: Author = None
    content: str
