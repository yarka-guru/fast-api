from fastapi import FastAPI
import redis

app = FastAPI()
r = redis.Redis(host='redis', port=6379, db=0)

@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.get("/counter")
def read_counter():
    r.incr('counter')
    return {"counter": r.incr('counter')}