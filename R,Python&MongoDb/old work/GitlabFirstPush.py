import glob
import pymongo
from pymongo import MongoClient
client = MongoClient()
db = client.test
path_smMain = r'/tmp/sm_main'
path_SRMAIN = r'/tmp/sr_main'
path_SRDetail = r'/tmp/sr_detail'
path_SmDetail = r'/tmp/sm_detail'
smMainAllFiles = glob.glob(path_smMain + '/*.txt')
srMainAllFiles = glob.glob(path_SRMAIN + '/*.txt')
srDetailAllFiles = glob.glob(path_SRDetail + '/*.txt')
smDetailAllFiles = glob.glob(path_SmDetail + '/*.txt')
#print smDetailAllFiles
list_ = []
a = []

for file_ in smDetailAllFiles:
    with open(file_) as f:
        for line in f:
            (SCTS,
             SCMSGREF,
             RECORDTYPE,
             CAUSE,
             EVENT,
             LOGGINGTIME,
             DEST_IMSI,
             DEST_VMSCADDR,
             NUMOFDELATTEMPTS,
             ACCESSMETHOD,
             SMORIGADDR,
             APP_NUM,
             SMDESTADDR,
             ROUTING_TYPE,
             NODE_ID,
             MAP_MESSAGE_ID,
             ) = line.rstrip().split(',')
            a.append(MAP_MESSAGE_ID)
unique_var = list(set(a)) # selecting the unique map_message_ID from llist
#print unique_var
count = 0
count1 = 0
for i in range(0,len(unique_var)):
    SMMAIN_SCTS = []
    SMMAIN_SCMSGREF = []
    SMMAIN_RECORDTYPE = []
    SMMAIN_CAUSE = []
    SMMAIN_EVENT = []
    SMMAIN_LOGGINGTIME = []
    SMMAIN_ACCESSMETHOD = []
    SMMAIN_SMORIGADDR = []
    SMMAIN_SMDESTADDR = []
    SMMAIN_DISPLAYADDRVALUE = []
    SMMAIN_ORIGADDR_TYPE = []
    SMMAIN_DESTADDR_TYPE = []
    SMMAIN_ORIG_IMSI = []
    SMMAIN_ORIG_VMSC = []
    SMMAIN_MSG_LEN = []
    SMMAIN_PID = []
    SMMAIN_DCS = []
    SMMAIN_DSR_REQ = []
    SMMAIN_PRIORITY = []
    SMMAIN_CONCAT_INFO = []
    SMMAIN_CLIENT_ID = []
    SMMAIN_SUBS_TYPE = []
    SMMAIN_APP_NUM = []
    SMMAIN_VALIDITY_PERIOD = []
    SMMAIN_DIALLED_NUM = []
    SMMAIN_ROUTING_TYPE=  []
    SMMAIN_NODE_ID = []
    SMMAIN_MAP_MESSAGE_ID= []
################################SM DETAIL VARIABLE
    SMDETAIL_SCTS = []
    SMDETAIL_SCMSGREF =  []
    SMDETAIL_RECORDTYPE = []
    SMDETAIL_CAUSE = []
    SMDETAIL_EVENT = []
    SMDETAIL_LOGGINGTIME = []
    SMDETAIL_DEST_IMSI= []
    SMDETAIL_DEST_VMSCADDR = []
    SMDETAIL_NUMOFDELATTEMPTS = []
    SMDETAIL_ACCESSMETHOD= []
    SMDETAIL_SMORIGADDR = []
    SMDETAIL_APP_NUM = []
    SMDETAIL_SMDESTADDR = []
    SMDETAIL_ROUTING_TYPE = []
    SMDETAIL_NODE_ID = []
    SMDETAIL_MAP_MESSAGE_ID = []
############################SR_MAIN VARIABLE
    SRMAIN_SCMSGREF = []
    SRMAIN_SCTS = []
    SRMAIN_SRORIGADDR =  []
    SRMAIN_SRDESTADDR = []
    SRMAIN_MSGID = []
    SRMAIN_SR_SCTS = []
    SRMAIN_STATUS = []
    SRMAIN_ERRCODE = []
    SRMAIN_CAUSE = []
    SRMAIN_EVENT = []
    SRMAIN_ACCESSMETHOD = []
    SRMAIN_DIALLED_NUM = []
    SRMAIN_LOGGINGTIME = []
    SRMAIN_NODE_ID= []
    SRMAIN_MAP_MESSAGE_ID = []
########SR DETAIL
    SRDETAIL_SCTS = []
    SRDETAIL_SCMSGREF = []
    SRDETAIL_CAUSE = []
    SRDETAIL_EVENT = []
    SRDETAIL_ACCESSMETHOD = []
    SRDETAIL_SRORIGADDR = []
    SRDETAIL_SRDESTADDR = []
    SRDETAIL_LOGGINGTIME = []
    SRDETAIL_NODE_ID = []


    for file_ in smMainAllFiles:
       with open(file_) as f:
           for line in f:
               if unique_var[i] in line:
                   count = count + 1
                   line = line.rstrip().split(",")
                   #line = line.split()
                   SMMAIN_SCTS=str(line[0])
                   SMMAIN_SCMSGREF=str(line[1])
                   SMMAIN_RECORDTYPE=str(line[2])
                   SMMAIN_CAUSE=str(line[3])
                   SMMAIN_EVENT=str(line[4])
                   SMMAIN_LOGGINGTIME=str(line[5])
                   SMMAIN_ACCESSMETHOD= str(line[6])
                   SMMAIN_SMORIGADDR = str(line[7])
                   SMMAIN_SMDESTADDR =str(line[8])
                   SMMAIN_DISPLAYADDRVALUE=str(line[9])
                   SMMAIN_ORIGADDR_TYPE=str(line[10])
                   SMMAIN_DESTADDR_TYPE=str(line[11])
                   SMMAIN_ORIG_IMSI=str(line[12])
                   SMMAIN_ORIG_VMSC=str(line[13])
                   SMMAIN_MSG_LEN=str(line[14])
                   SMMAIN_PID=str(line[15])
                   SMMAIN_DCS =str(line[16])
                   SMMAIN_DSR_REQ =str(line[17])
                   SMMAIN_PRIORITY=str(line[18])
                   SMMAIN_CONCAT_INFO=str(line[19])
                   SMMAIN_CLIENT_ID=str(line[20])
                   SMMAIN_SUBS_TYPE=str(line[21])
                   SMMAIN_APP_NU=str(line[22])
                   SMMAIN_VALIDITY_PERIOD=str(line[23])
                   SMMAIN_DIALLED_NUM=str(line[24])
                   SMMAIN_ROUTING_TYPE=str(line[25])
                   SMMAIN_NODE_ID = str(line[26])
                   SMMAIN_MAP_MESSAGE_ID=str(line[27])
                   print "### SM_MAIN FILE"
                   #print SMMAIN_MAP_MESSAGE_ID
                   # print line
    for file_ in smDetailAllFiles:
        with open(file_) as f:
            for line1 in f:
                if unique_var[i] in line1:
                    line1 = line1.rstrip().split(",")
                    SMDETAIL_SCTS= str(line1[0])
                    SMDETAIL_SCMSGREF= str(line1[1])
                    SMDETAIL_RECORDTYPE= str(line1[2])
                    SMDETAIL_CAUSE = str(line1[3])
                    SMDETAIL_EVENT = str(line1[4])
                    SMDETAIL_LOGGINGTIME = str(line1[5])
                    SMDETAIL_DEST_IMSI = str(line1[6])
                    SMDETAIL_DEST_VMSCADDR = str(line1[7])
                    SMDETAIL_NUMOFDELATTEMPTS = str(line1[8])
                    SMDETAIL_ACCESSMETHOD = str(line1[9])
                    SMDETAIL_SMORIGADDR = str(line1 [10])
                    SMDETAIL_APP_NUM = str(line1[11])
                    SMDETAIL_SMDESTADDR = str(line1[12])
                    SMDETAIL_ROUTING_TYPE = str(line1[13])
                    SMDETAIL_NODE_ID = str(line1[14])
                    SMDETAIL_MAP_MESSAGE_ID = str(line1[15])
                    #print "# SMDETAIL FILE"
                    #print SMDETAIL_MAP_MESSAGE_ID
                    #print line1
    for file_ in  srMainAllFiles:
       with open(file_) as f:
           for line2 in f:
               if unique_var[i] in line2:
                   line = line2.rstrip().split(",")
                   SRMAIN_SCTS =  str(line[0])
                   SRMAIN_SCMSGREF = str(line[1])
                   SRMAIN_SRORIGADDR = str(line[2])
                   SRMAIN_SRDESTADDR = str(line[3])
                   SRMAIN_MSGID = str(line[4])
                   SRMAIN_SR_SCTS = str(line[5])
                   SRMAIN_STATUS = str(line[6])
                   SRMAIN_ERRCODE = str(line[7])
                   SRMAIN_CAUSE = str(line[8])
                   SRMAIN_EVENT = str(line[9])
                   SRMAIN_ACCESSMETHOD = str(line[10])
                   SRMAIN_DIALLED_NUM = str(line[11])
                   SRMAIN_LOGGINGTIME = str(line[12])
                   SRMAIN_NODE_ID = str(line[13])
                   SRMAIN_MAP_MESSAGE_ID = str(line[14])
                   #print "#SRMAIN"
                   #print SRMAIN_MAP_MESSAGE_ID
                   #print line
    #print "MAKING THE PROCESS"

    for i in srDetailAllFiles:
        with open(i) as fiel:
            for k in fiel:
                if str(k.split(',')[0]) == str(SRMAIN_SCTS) and str(k.split(',')[1]) == str(SRMAIN_SCMSGREF):
                    k = k.rstrip().split(",")
                    SRDETAIL_SCTS = str(k[0])
                    SRDETAIL_SCMSGREF = str(k[1])
                    SRDETAIL_CAUSE = str(k[2])
                    SRDETAIL_EVENT = str(k[3])
                    SRDETAIL_ACCESSMETHOD = str(k[4])
                    SRDETAIL_SRORIGADDR = str(k[5])
                    SRDETAIL_LOGGINGTIME = str(k[6])
                    SRDETAIL_NODE_ID = str(k[7])
                    #print "################SRDETAIL##########"
                    #print k
    db.EVR.insert_one(
        {
            "MAP_MESSAGE_ID":SMDETAIL_MAP_MESSAGE_ID,
            "SM_DETAIL":[{
                "SCTS":SMDETAIL_SCTS,
                "SCMSGREF":SMDETAIL_SCMSGREF,
                "RECORDTYPE":SMDETAIL_RECORDTYPE,
                "CAUSE":SMDETAIL_CAUSE,
                "EVENT":SMDETAIL_CAUSE,
                "LOGGINGTIME":SMDETAIL_LOGGINGTIME,
                "DEST_IMSI":SMDETAIL_DEST_IMSI,
                "DEST_VMSCADDR":SMDETAIL_DEST_VMSCADDR,
                "NUMOFDELATTEMPTS":SMDETAIL_NUMOFDELATTEMPTS,
                "ACCESSMETHOD":SMDETAIL_ACCESSMETHOD,
                "SMORIGADDR":SMDETAIL_SMORIGADDR,
                "APP_NUM":SMDETAIL_APP_NUM,
                "SMDESTADDR":SMDETAIL_SMDESTADDR,
                "ROUTING_TYPE":SMDETAIL_ROUTING_TYPE,
                "NODE_ID":SMDETAIL_NODE_ID
            }],
            "SM_MAIN":[{
                "SCTS":SMMAIN_SCTS,
                "SCMSGREF":SMMAIN_SCMSGREF,
                "RECORDTYPE":SMMAIN_RECORDTYPE,
                "CAUSE":SMMAIN_CAUSE,
                "EVENT":SMMAIN_EVENT,
                "LOGGINGTIME":SMMAIN_LOGGINGTIME,
                "ACCESSMETHOD":SMMAIN_ACCESSMETHOD,
                "SMORIGADDR":SMMAIN_SMORIGADDR,
                "SMDESTADDR":SMMAIN_SMDESTADDR,
                "DISPLAYADDRVALUE":SMMAIN_DISPLAYADDRVALUE,
                "ORIGADDR_TYPE":SMMAIN_ORIGADDR_TYPE,
                "DESTADDR_TYPE":SMMAIN_DESTADDR_TYPE,
                "ORIG_IMSI":SMMAIN_ORIG_IMSI,
                "ORIG_VMSC":SMMAIN_ORIG_VMSC,
                "MSG_LEN":SMMAIN_MSG_LEN,
                "PID":SMMAIN_PID,
                "DCS":SMMAIN_DCS,
                "DSR_REQ":SMMAIN_DSR_REQ,
                "PRIORITY":SMMAIN_PRIORITY,
                "CONCAT_INFO":SMMAIN_CONCAT_INFO,
                "CLIENT_ID":SMMAIN_CLIENT_ID,
                "SUBS_TYPE":SMMAIN_SUBS_TYPE,
                "APP_NUM":SMMAIN_APP_NUM,
                "VALIDITY_PERIOD":SMMAIN_VALIDITY_PERIOD,
                "DIALLED_NUM":SMMAIN_DIALLED_NUM,
                "ROUTING_TYPE":SMMAIN_ROUTING_TYPE,
                "NODE_ID" :SMMAIN_NODE_ID
            }],
            "SR_MAIN" :[{
                "SCTS":SRMAIN_SCTS,
                "SCMSGREF":SRMAIN_SCMSGREF,
                "SRORIGADDR":SRMAIN_SRORIGADDR,
                "SRDESTADDR":SRMAIN_SRDESTADDR,
                "MSGID":SRMAIN_MSGID,
                "SR_SCTS":SRMAIN_SR_SCTS,
                "SM_STATUS":SRMAIN_STATUS,
                "SM_ERRCODE":SRMAIN_ERRCODE,
                "CAUSE":SRMAIN_CAUSE,
                "EVENT":SRMAIN_EVENT,
                "ACCESSMETHOD":SRMAIN_ACCESSMETHOD,
                "DIALLED_NUM":SRMAIN_DIALLED_NUM,
                "LOGGINGTIME":SRMAIN_LOGGINGTIME,
                "NODE_ID":SRMAIN_NODE_ID
            }],
            "SR_DETAIL":[{
                "SCTS":SRDETAIL_SCTS,
                "SCMSGREF":SRDETAIL_SCMSGREF,
                "CAUSE":SRDETAIL_CAUSE,
                "EVENT":SRDETAIL_EVENT,
                "SRORIGADDR":SRDETAIL_SRORIGADDR,
                "SRDESTADDR":SRDETAIL_SRDESTADDR,
                "LOGGINGTIME":SRDETAIL_LOGGINGTIME,
                "NODE_ID": NODE_ID
            }]
        }
    )



