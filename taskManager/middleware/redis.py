import redis

class RedisHelper:
    def __init__(self, host, port):
        self.host = host
        self.port = port

    def createSession(self):
        return redis.Redis(host=self.host, port=self.port)
    
    def insert(self, key: str, value: str ,ttl: int):
        r = self.createSession()
        r.setex(key,ttl, value)
        r.close()

    def get(self, key: str):
        r = self.createSession()
        value = r.get(key)
        r.close()
        return value
