
"""  connect to MongoDB """
import sys
from pymongo import MongoClient
from pymongo.errors import ConnectionFailure

def main():
	try:
		client = MongoClient('localhost',27017)
		print "connected successfully"
		print client
	except ConnectionFailure,e:
	    sys.stderr.write("Could not connect to MongoDB: %s" % e)
        sys.exit(1)	

    db = client.EVR
    print "Getting the database"    

if __name__ == '__main__':
	main()