import pymongo
import gc
from pymongo import MongoClient
import glob
import csv
client = MongoClient()
db = client.test
print "startig PAth"
#path_smMain = r'C:/Users/Aman Kumar/Documents/dashboard/evr_vts01/EVR_MAIN/EVRDATA/sm_main' #/tmp/sm_main
path_smMain = r'/evr/subset_data/EVR_SM_MAIN' #/tmp/sm_main
#path_smMain = r'/tmp/sm_main'
#path_SRMAIN = r'C:/Users/Aman Kumar/Documents/dashboard/evr_vts01/EVR_MAIN/EVRDATA/sr_main'  #/tmp/sr_main
path_SRMAIN = r'/evr/subset_data/EVR_SR_MAIN'
#path_SRMAIN = r'/tmp/sr_main'
#path_SRDetail = r'C:/Users/Aman Kumar/Documents/dashboard/evr_vts01/EVR_MAIN/EVRDATA/sr_detail' #/tmp/sr_detail
path_SRDetail = r'/evr/subset_data/EVR_SR_DETAIL'
#path_SRDetail = r'/tmp/sr_detail'
#path_SmDetail = r'C:/Users/Aman Kumar/Documents/dashboard/evr_vts01/EVR_MAIN/EVRDATA/sm_detail' #/tmp/sm_detail
path_SmDetail = r'/evr/subset_data/EVR_SM_DETAIL'
path_SmDetail = r'/tmp/SM_detail'
path_submitDetail = r'/evr/CODE/'
print "starting file"
#path_SmDetail = r'/tmp/sm_detail' #/tmp/sm_detail
smMainAllFiles = glob.glob(path_smMain + '/EVR_SM_MAIN*.txt')
srMainAllFiles = glob.glob(path_SRMAIN + '/EVR_SR_MAIN*.txt')
srDetailAllFiles = glob.glob(path_SRDetail + '/EVR_SR_DETAIL*.txt')
smDetailAllFiles = glob.glob(path_SmDetail + '/EVR_SM_DETAIL*.txt')
submitAllFiles = glob.glob(path_submitDetail + '/*.csv')
print "starting unique_var"
unique_var = []
a = []
datasmDetail = {}
print "Starting SMDETAIL"
for file_ in smDetailAllFiles:
    with open(file_) as f:
        for line in f:
            line = line.rstrip().split(",")
            a.append(line[15])
            datasmDetail[line[15]] = line            
unique_var = list(set(a))
print "Loading SM DETAIL"
for i in unique_var:
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
    SMMAIN_ROUTING_TYPE = []
    SMMAIN_NODE_ID = []
    SMMAIN_MAP_MESSAGE_ID = []
    ################################SM DETAIL VARIABLE
    SMDETAIL_SCTS = []
    SMDETAIL_SCMSGREF = []
    SMDETAIL_RECORDTYPE = []
    SMDETAIL_CAUSE = []
    SMDETAIL_EVENT = []
    SMDETAIL_LOGGINGTIME = []
    SMDETAIL_DEST_IMSI = []
    SMDETAIL_DEST_VMSCADDR = []
    SMDETAIL_NUMOFDELATTEMPTS = []
    SMDETAIL_ACCESSMETHOD = []
    SMDETAIL_SMORIGADDR = []
    SMDETAIL_APP_NUM = []
    SMDETAIL_SMDESTADDR = []
    SMDETAIL_ROUTING_TYPE = []
    SMDETAIL_NODE_ID = []
    SMDETAIL_MAP_MESSAGE_ID = []
    ############################SR_MAIN VARIABLE
    SRMAIN_SCMSGREF = []
    SRMAIN_SCTS = []
    SRMAIN_SRORIGADDR = []
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
    SRMAIN_NODE_ID = []
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
    MSISDN = []
    MSGCONTECT = []
    SRDETAIL_SRDESTADDR = []
    if i in datasmDetail:
        SMDETAIL_MAP_MESSAGE_ID = datasmDetail[str(i)][15]
        SMDETAIL_NODE_ID = datasmDetail[str(i)][14]
        SMDETAIL_ROUTING_TYPE = datasmDetail[str(i)][13]
        SMDETAIL_SMDESTADDR =datasmDetail[str(i)][12]
        SMDETAIL_APP_NUM = datasmDetail[str(i)][11]
        SMDETAIL_SMORIGADDR = datasmDetail[str(i)][10]
        SMDETAIL_ACCESSMETHOD = datasmDetail[str(i)][9]
        SMDETAIL_NUMOFDELATTEMPTS= datasmDetail[str(i)][8]
        SMDETAIL_DEST_VMSCADDR = datasmDetail[str(i)][7]
        SMDETAIL_DEST_IMSI = datasmDetail[str(i)][6]
        SMDETAIL_LOGGINGTIME = datasmDetail[str(i)][5]
        SMDETAIL_EVENT = datasmDetail[str(i)][4]
        SMDETAIL_CAUSE = datasmDetail[str(i)][3]
        SMDETAIL_RECORDTYPE = datasmDetail[str(i)][2]
        SMDETAIL_SCMSGREF = datasmDetail[str(i)][1]
        SMDETAIL_SCTS = datasmDetail[str(i)][0]
        del datasmDetail[str(i)]

        db.EVR.insert_one(
        {
            "MAP_MESSAGE_ID": SMDETAIL_MAP_MESSAGE_ID,
            "MSISDN": str(SMMAIN_DIALLED_NUM),
            "SM_DETAIL": [{
                "SCTS": SMDETAIL_SCTS,
                "SCMSGREF": SMDETAIL_SCMSGREF,
                "RECORDTYPE": SMDETAIL_RECORDTYPE,
                "CAUSE": SMDETAIL_CAUSE,
                "EVENT": SMDETAIL_CAUSE,
                "LOGGINGTIME": SMDETAIL_LOGGINGTIME,
                "DEST_IMSI": SMDETAIL_DEST_IMSI,
                "DEST_VMSCADDR": SMDETAIL_DEST_VMSCADDR,
                "NUMOFDELATTEMPTS": SMDETAIL_NUMOFDELATTEMPTS,
                "ACCESSMETHOD": SMDETAIL_ACCESSMETHOD,
                "SMORIGADDR": SMDETAIL_SMORIGADDR,
                "APP_NUM": SMDETAIL_APP_NUM,
                "SMDESTADDR": SMDETAIL_SMDESTADDR,
                "ROUTING_TYPE": SMDETAIL_ROUTING_TYPE,
                "NODE_ID": SMDETAIL_NODE_ID
            }],
            "SM_MAIN": [{
                "SCTS": SMMAIN_SCTS,
                "SCMSGREF": SMMAIN_SCMSGREF,
                "RECORDTYPE": SMMAIN_RECORDTYPE,
                "CAUSE": SMMAIN_CAUSE,
                "EVENT": SMMAIN_EVENT,
                "LOGGINGTIME": SMMAIN_LOGGINGTIME,
                "ACCESSMETHOD": SMMAIN_ACCESSMETHOD,
                "SMORIGADDR": SMMAIN_SMORIGADDR,
                "SMDESTADDR": SMMAIN_SMDESTADDR,
                "DISPLAYADDRVALUE": SMMAIN_DISPLAYADDRVALUE,
                "ORIGADDR_TYPE": SMMAIN_ORIGADDR_TYPE,
                "DESTADDR_TYPE": SMMAIN_DESTADDR_TYPE,
                "ORIG_IMSI": SMMAIN_ORIG_IMSI,
                "ORIG_VMSC": SMMAIN_ORIG_VMSC,
                "MSG_LEN": SMMAIN_MSG_LEN,
                "PID": SMMAIN_PID,
                "DCS": SMMAIN_DCS,
                "DSR_REQ": SMMAIN_DSR_REQ,
                "PRIORITY": SMMAIN_PRIORITY,
                "CONCAT_INFO": SMMAIN_CONCAT_INFO,
                "CLIENT_ID": SMMAIN_CLIENT_ID,
                "SUBS_TYPE": SMMAIN_SUBS_TYPE,
                "APP_NUM": SMMAIN_APP_NUM,
                "VALIDITY_PERIOD": SMMAIN_VALIDITY_PERIOD,
                "DIALLED_NUM": SMMAIN_DIALLED_NUM,
                "ROUTING_TYPE": SMMAIN_ROUTING_TYPE,
                "NODE_ID": SMMAIN_NODE_ID,
                "MSG_CONTENT": MSGCONTECT
            }],
            "SR_MAIN": [{
                "SCTS": SRMAIN_SCTS,
                "SCMSGREF": SRMAIN_SCMSGREF,
                "SRORIGADDR": SRMAIN_SRORIGADDR,
                "SRDESTADDR": SRMAIN_SRDESTADDR,
                "MSGID": SRMAIN_MSGID,
                "SR_SCTS": SRMAIN_SR_SCTS,
                "SM_STATUS": SRMAIN_STATUS,
                "SM_ERRCODE": SRMAIN_ERRCODE,
                "CAUSE": SRMAIN_CAUSE,
                "EVENT": SRMAIN_EVENT,
                "ACCESSMETHOD": SRMAIN_ACCESSMETHOD,
                "DIALLED_NUM": SRMAIN_DIALLED_NUM,
                "LOGGINGTIME": SRMAIN_LOGGINGTIME,
                "NODE_ID": SRMAIN_NODE_ID
            }],
            "SR_DETAIL": [{
                "SCTS": SRDETAIL_SCTS,
                "SCMSGREF": SRDETAIL_SCMSGREF,
                "CAUSE": SRDETAIL_CAUSE,
                "EVENT": SRDETAIL_EVENT,
                "SRORIGADDR": SRDETAIL_SRORIGADDR,
                "SRDESTADDR": SRDETAIL_SRDESTADDR,
                "LOGGINGTIME": SRDETAIL_LOGGINGTIME,
                "NODE_ID": SRDETAIL_NODE_ID
            }]
        })

datasmDetail.clear()
print "Completed SM_DETAIL"

datasmMain = {}
for file_ in smMainAllFiles:
    with open(file_) as f:
        for line in f:
            line = line.rstrip().split(",")
            datasmMain[line[27]] = line
print "STARTING SMMAIN"            
for i in unique_var:
    if i in datasmMain:
        #print "SMMAIN"
        #print datasmMain[str(i)]
        SMMAIN_SCTS = datasmMain[str(i)][0]
        SMMAIN_SCMSGREF = datasmMain[str(i)][1]
        SMMAIN_RECORDTYPE = datasmMain[str(i)][2]
        SMMAIN_CAUSE = datasmMain[str(i)][3]
        SMMAIN_EVENT = datasmMain[str(i)][4]
        SMMAIN_LOGGINGTIME = datasmMain[str(i)][5]
        SMMAIN_ACCESSMETHOD = datasmMain[str(i)][6]
        SMMAIN_SMORIGADDR = datasmMain[str(i)][7]
        SMMAIN_SMDESTADDR = datasmMain[str(i)][8]
        SMMAIN_DISPLAYADDRVALUE = datasmMain[str(i)][9]
        SMMAIN_ORIGADDR_TYPE = datasmMain[str(i)][10]
        SMMAIN_DESTADDR_TYPE = datasmMain[str(i)][11]
        SMMAIN_ORIG_IMSI = datasmMain[str(i)][12]
        SMMAIN_ORIG_VMSC = datasmMain[str(i)][13]
        SMMAIN_MSG_LEN = datasmMain[str(i)][14]
        SMMAIN_PID = datasmMain[str(i)][15]
        SMMAIN_DCS = datasmMain[str(i)][16]
        SMMAIN_DSR_REQ = datasmMain[str(i)][17]
        SMMAIN_PRIORITY = datasmMain[str(i)][18]
        SMMAIN_CONCAT_INFO = datasmMain[str(i)][19]
        SMMAIN_CLIENT_ID = datasmMain [str(i)][20]
        SMMAIN_SUBS_TYPE = datasmMain[str(i)][21]
        SMMAIN_APP_NUM = datasmMain[str(i)][22]
        SMMAIN_VALIDITY_PERIOD = datasmMain[str(i)][23]
        SMMAIN_DIALLED_NUM = datasmMain[str(i)][24]
        SMMAIN_ROUTING_TYPE = datasmMain[str(i)][25]
        SMMAIN_NODE_ID = datasmMain[str(i)][26]
        SMMAIN_MAP_MESSAGE_ID = datasmMain[str(i)][27]
        del datasmMain[str(i)]
        db.EVR.update_one (
            {
            "MAP_MESSAGE_ID": str(i)},
            {$set :
              {"SM_MAIN":
                "SCTS": SMMAIN_SCTS,
                "SCMSGREF": SMMAIN_SCMSGREF,
                "RECORDTYPE": SMMAIN_RECORDTYPE,
                "CAUSE": SMMAIN_CAUSE,
                "EVENT": SMMAIN_EVENT,
                "LOGGINGTIME": SMMAIN_LOGGINGTIME,
                "ACCESSMETHOD": SMMAIN_ACCESSMETHOD,
                "SMORIGADDR": SMMAIN_SMORIGADDR,
                "SMDESTADDR": SMMAIN_SMDESTADDR,
                "DISPLAYADDRVALUE": SMMAIN_DISPLAYADDRVALUE,
                "ORIGADDR_TYPE": SMMAIN_ORIGADDR_TYPE,
                "DESTADDR_TYPE": SMMAIN_DESTADDR_TYPE,
                "ORIG_IMSI": SMMAIN_ORIG_IMSI,
                "ORIG_VMSC": SMMAIN_ORIG_VMSC,
                "MSG_LEN": SMMAIN_MSG_LEN,
                "PID": SMMAIN_PID,
                "DCS": SMMAIN_DCS,
                "DSR_REQ": SMMAIN_DSR_REQ,
                "PRIORITY": SMMAIN_PRIORITY,
                "CONCAT_INFO": SMMAIN_CONCAT_INFO,
                "CLIENT_ID": SMMAIN_CLIENT_ID,
                "SUBS_TYPE": SMMAIN_SUBS_TYPE,
                "APP_NUM": SMMAIN_APP_NUM,
                "VALIDITY_PERIOD": SMMAIN_VALIDITY_PERIOD,
                "DIALLED_NUM": SMMAIN_DIALLED_NUM,
                "ROUTING_TYPE": SMMAIN_ROUTING_TYPE,
                "NODE_ID": SMMAIN_NODE_ID,
                "MSG_CONTENT": MSGCONTECT}}
            )
datasmMain.clear()   

print "COMPLTED SMMAIN"     















