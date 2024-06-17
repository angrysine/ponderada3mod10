import psycopg2

class PostegresHelper():

    
    def __init__(self,user,password,host,dbname ):
        self.user = user

        self.password = password

        self.dbname = dbname

        self.host = host

    def createSession(self):
        conn = psycopg2.connect( user = self.user, password = self.password, host = self.host, dbname = self.dbname, port = "5432")
        return conn.cursor(),conn

    def executeInsert(self,statment,params):
        cursor,conn = self.createSession()
        cursor.execute(statment,params)
        conn.commit()
        cursor.close()
        conn.close()


    def executeSelect(self, statment,params):
        cursor,conn = self.createSession()
        cursor.execute(statment,params)
        response = cursor.fetchall()
        cursor.close()
        conn.close()
    
        return response
    
        
    

