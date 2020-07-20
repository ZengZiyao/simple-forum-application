from pydantic import BaseModel


class Author(BaseModel):
    username: str = None
    id: str = None
    photo: str = None

