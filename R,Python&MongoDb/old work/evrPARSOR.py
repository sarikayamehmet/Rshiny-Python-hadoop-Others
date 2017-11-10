#!/usr/bin/python
# -*- coding: utf-8 -*-
import glob
import pandas as pd
import pymongo
from pymongo import MongoClient

# get data file names

client = MongoClient()
db = client.test
path_smMain = r'/tmp/EVR_SM_MAIN'
path_SRMAIN = r'/tmp/EVR_SR_MAIN'
path_SRDetail = r'/tmp/EVR_SR_DETAIL'

smMainAllFiles = glob.glob(path_smMain + '/*.txt')
srMainAllFiles = glob.glob(path_SRMAIN + '/*.txt')
srDetailAllFiles = glob.glob(path_SRDetail + '/*.txt')

# print srDetailAllFiles

sr_detail = pd.DataFrame()
sr_main = pd.DataFrame()
sm_main = pd.DataFrame()

list_ = []

# dataframe for the srDetail



for file_ in srDetailAllFiles:
    with open (file_) as f:
        for line in f:
            SCTS,SCMSGREF,CAUSE,EVENT,ACCESSMETHOD,SRORIGADDR,SRDESTADDR,LOGGINGTIME,NODE_ID = line.rstrip().split(',')
            db.EVR.insert_one

'''
sr_detail = pd.concat(list_)

sr_detail.columns = [
    'SCTS',
    'SCMSGREF',
    'CAUSE',
    'EVENT',
    'ACCESSMETHOD',
    'SRORIGADDR',
    'SRDESTADDR',
    'LOGGINGTIME',
    'NODE_ID',x
]

# data frame for the srMain

for file_ in srMainAllFiles:
    df = pd.read_csv(file_, sep=',', header=None)
    list_.append(df)
sr_main = pd.concat(list_)

# print sr_main

sr_main.columns = [
    'SCTS',
    'SCMSGREF',
    'SRORIGADDR',
    'SRDESTADDR',
    'MSGID',
    'SR_SCTS',
    'SM_STATUS',
    'SM_ERRCODE',
    'CAUSE',
    'EVENT',
    'ACCESSMETHOD',
    'DIALLED_NUM',
    'LOGGINGTIME',
    'NODE_ID',
    'MAP_MESSAGE_ID',
]

# print sr_main
# data frame for the sm_main

for file_ in smMainAllFiles:
    df = pd.read_csv(file_, sep=',', header=None)
    list_.append(df)
sm_main = pd.concat(list_)
sm_main.columns = [
    'SCTS',
    'SCMSGREF',
    'RECORDTYPE',
    'CAUSE',
    'EVENT',
    'LOGGINGTIME',
    'ACCESSMETHOD',
    'SMORIGADDR',
    'SMDESTADDR',
    'DISPLAYADDRVALUE',
    'ORIGADDR_TYPE',
    'DESTADDR_TYPE',
    'ORIG_IMSI',
    'ORIG_VMSC',
    'MSG_LEN',
    'PID',
    'DCS',
    'DSR_REQ',
    'PRIORITY',
    'CONCAT_INFO',
    'CLIENT_ID',
    'SUBS_TYPE',
    'APP_NUM',
    'VALIDITY_PERIOD',
    'DIALLED_NUM',
    'ROUTING_TYPE',
    'NODE_ID',
    'MAP_MESSAGE_ID',
]

path_smDetail = r'/tmp/EVR_SM_DETAIL'

smMainDetailAllFiles = glob.glob(path_smDetail + '/*.txt')
frame = pd.DataFrame()
list_ = []
for file_ in smMainDetailAllFiles:
    df = pd.read_csv(file_, index_col=None, header=0)
    list_.append(df)
frame = pd.concat(list_)

frame.columns = [
    'SCTS',
    'SCMSGREF',
    'RECORDTYPE',
    'CAUSE',
    'EVENT',
    'LOGGINGTIME',
    'DEST_IMSI',
    'DEST_VMSCADDR',
    'NUMOFDELATTEMPTS',
    'ACCESSMETHOD',
    'SMORIGADDR',
    'APP_NUM',
    'SMDESTADDR',
    'ROUTING_TYPE',
    'NODE_ID',
    'MAP_MESSAGE_ID',
]
sm_detail = pd.DataFrame()
sm_detail = frame
# print sm_detail

uniqueVar_detail = sm_detail.MAP_MESSAGE_ID.unique()
print "before for"
#for i in range(0, len(uniqueVar_detail)):
    #dataSMDETAIL = sm_detail[sm_detail['MAP_MESSAGE_ID']
     #                        == uniqueVar_detail[i]]
    #dataSMMAIN = sm_main[sm_main['MAP_MESSAGE_ID']
     #                    == uniqueVar_detail[i]]
    #dataSRMAIN = sr_main[sr_main['MAP_MESSAGE_ID']
     #                    == uniqueVar_detail[i]]
    #dataSRDETAIL = pd.merge(dataSRMAIN, sr_detail, on=['SCTS',
     #                                                  'SCMSGREF'])
db.EVR.insert_many({
        'MAP_MESSAGE_ID': str(dataSMDETAIL.MAP_MESSAGE_ID),
        'SM_DETAIL': [{
            'SCTS': str(dataSMDETAIL.SCTS),
            'SCMSGREF': str(dataSMDETAIL.SCMSGREF),
            'RECORDTYPE': str(dataSMDETAIL.RECORDTYPE),
            'CAUSE': str(dataSMDETAIL.CAUSE),
            'EVENT': str(dataSMDETAIL.EVENT),
            'LOGGINGTIME': str(dataSMDETAIL.LOGGINGTIME),
            'DEST_IMSI': str(dataSMDETAIL.DEST_IMSI),
            'DEST_VMSCADDR': str(dataSMDETAIL.DEST_VMSCADDR),
            'NUMOFDELATTEMPTS': str(dataSMDETAIL.NUMOFDELATTEMPTS),
            'ACCESSMETHOD': str(dataSMDETAIL.ACCESSMETHOD),
            'SMORIGADDR': str(dataSMDETAIL.SMORIGADDR),
            'APP_NUM': str(dataSMDETAIL.APP_NUM),
            'SMDESTADDR': str(dataSMDETAIL.SMDESTADDR),
            'ROUTING_TYPE': str(dataSMDETAIL.ROUTING_TYPE),
            'NODE_ID': str(dataSMDETAIL.NODE_ID),
        }],
        'SM_MAIN': [{
            'SCTS': str(dataSMMAIN.SCTS),
            'SCMSGREF': str(dataSMMAIN.SCMSGREF),
            'RECORDTYPE': str(dataSMMAIN.RECORDTYPE),
            'CAUSE': str(dataSMMAIN.CAUSE),
            'EVENT': str(dataSMMAIN.EVENT),
            'LOGGINGTIME': str(dataSMMAIN.LOGGINGTIME),
            'ACCESSMETHOD': str(dataSMMAIN.ACCESSMETHOD),
            'SMORIGADDR': str(dataSMMAIN.SMORIGADDR),
            'SMDESTADDR': str(dataSMMAIN.SMDESTADDR),
            'DISPLAYADDRVALUE': str(dataSMMAIN.DISPLAYADDRVALUE),
            'ORIGADDR_TYPE': str(dataSMMAIN.ORIGADDR_TYPE),
            'DESTADDR_TYPE': str(dataSMMAIN.DESTADDR_TYPE),
            'ORIG_IMSI': str(dataSMMAIN.ORIG_IMSI),
            'ORIG_VMSC': str(dataSMMAIN.ORIG_VMSC),
            'MSG_LEN': str(dataSMMAIN.MSG_LEN),
            'PID': str(dataSMMAIN.PID),
            'DCS': str(dataSMMAIN.DCS),
            'DSR_REQ': str(dataSMMAIN.DSR_REQ),
            'PRIORITY': str(dataSMMAIN.PRIORITY),
            'CONCAT_INFO': str(dataSMMAIN.CONCAT_INFO),
            'CLIENT_ID': str(dataSMMAIN.CLIENT_ID),
            'SUBS_TYPE': str(dataSMMAIN.SUBS_TYPE),
            'APP_NUM': str(dataSMMAIN.APP_NUM),
            'VALIDITY_PERIOD': str(dataSMMAIN.VALIDITY_PERIOD),
            'DIALLED_NUM': str(dataSMMAIN.DIALLED_NUM),
            'ROUTING_TYPE': str(dataSMMAIN.ROUTING_TYPE),
            'NODE_ID': str(dataSMMAIN.NODE_ID),
        }],
        'SR_DETAIL': [{
            'SCTS': str(dataSRDETAIL.SCTS),
            'SCMSGREF': str(dataSRDETAIL.SCMSGREF),
            'CAUSE': str(dataSRDETAIL.CAUSE),
            'EVENT': str(dataSRDETAIL.EVENT),
            'ACCESSMETHOD': str(dataSRDETAIL.ACCESSMETHOD),
            'SRORIGADDR': str(dataSRDETAIL.SRORIGADDR),
            'SRDESTADDR': str(dataSRDETAIL.SRDESTADDR),
            'LOGGINGTIME': str(dataSRDETAIL.LOGGINGTIME),
            'NODE_ID': str(dataSRDETAIL.NODE_ID),
        }],
        'SR_MAIN': [{
            'SCTS': str(dataSRMAIN.SCTS),
            'SCMSGREF': str(dataSRMAIN.SCMSGREF),
            'SRORIGADDR': str(dataSRMAIN.SRORIGADDR),
            'SRDESTADDR': str(dataSRMAIN.SRDESTADDR),
            'MSGID': str(dataSRMAIN.MSGID),
            'SR_SCTS': str(dataSRMAIN.SR_SCTS),
            'SM_STATUS': str(dataSRMAIN.SM_STATUS),
            'SM_ERRCODE': str(dataSRMAIN.SM_ERRCODE),
            'CAUSE': str(dataSRMAIN.CAUSE),
            'EVENT': str(dataSRMAIN.EVENT),
            'ACCESSMETHOD': str(dataSRMAIN.ACCESSMETHOD),
            'DIALLED_NUM': str(dataSRMAIN.DIALLED_NUM),
            'LOGGINGTIME': str(dataSRMAIN.LOGGINGTIME),
            'NODE_ID': str(dataSRMAIN.NODE_ID),
        }],
    })

print "DONE"


'''