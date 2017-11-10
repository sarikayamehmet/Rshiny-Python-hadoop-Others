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
path_smDetail = r'/tmp/EVR_SM_DETAIL'
# print srDetailAllFiles

sr_detail = pd.DataFrame()
sr_main = pd.DataFrame()
sm_main = pd.DataFrame()

list_ = []

# dataframe for the srDetail
###################################################################################################
for file_ in srDetailAllFiles:
    with open(file_) as f:
        for line in f:
            (
                SCTS,
                SCMSGREF,
                CAUSE,
                EVENT,
                ACCESSMETHOD,
                SRORIGADDR,
                SRDESTADDR,
                LOGGINGTIME,
                NODE_ID,
            ) = line.rstrip().split(',')
            db.EVRSRMAIN.insert_one({
                'SR_MAIN': [{
                    'SCTS': str(SCTS),
                    'SCMSGREF': str(SCMSGREF),
                    'SRORIGADDR': str(SRORIGADDR),
                    'SRDESTADDR': str(SRDESTADDR),
                    'MSGID': str(MSGID),
                    'SR_SCTS': str(SR_SCTS),
                    'SM_STATUS': str(SM_STATUS),
                    'SM_ERRCODE': str(SM_ERRCODE),
                    'CAUSE': str(CAUSE),
                    'EVENT': str(EVENT),
                    'ACCESSMETHOD': str(ACCESSMETHOD),
                    'DIALLED_NUM': str(DIALLED_NUM),
                    'LOGGINGTIME': str(LOGGINGTIME),
                    'NODE_ID': str(NODE_ID)
            })

            # data frame for the srMain

for file_ in srMainAllFiles:
    with open(file_) as f:
        for line in f:
            (
                SCTS,
                SCMSGREF,
                SRORIGADDR,
                SRDESTADDR,
                MSGID,
                SR_SCTS,
                SM_STATUS,
                SM_ERRCODE,
                CAUSE,
                EVENT,
                ACCESSMETHOD,
                DIALLED_NUM,
                LOGGINGTIME,
                NODE_ID,
                MAP_MESSAGE_ID,
            ) = line.rstrip().split(',')
            db.EVRSRMAIN.insert_one({
                'SR_DETAIL': [{
                    'SCTS': str(SCTS),
                    'SCMSGREF': str(SCMSGREF),
                    'CAUSE': str(CAUSE),
                    'EVENT': str(EVENT),
                    'ACCESSMETHOD': str(ACCESSMETHOD),
                    'SRORIGADDR': str(SRORIGADDR),
                    'SRDESTADDR': str(SRDESTADDR),
                    'LOGGINGTIME': str(LOGGINGTIME),
                    'NODE_ID': str(NODE_ID)

            })

for file_ in smMainAllFiles:
    with open(file_) as f:
        for line in f:
            (
                SCTS,
                SCMSGREF,
                RECORDTYPE,
                CAUSE,
                EVENT,
                LOGGINGTIME,
                ACCESSMETHOD,
                SMORIGADDR,
                SMDESTADDR,
                DISPLAYADDRVALUE,
                ORIGADDR_TYPE,
                DESTADDR_TYPE,
                ORIG_IMSI,
                ORIG_VMSC,
                MSG_LEN,
                PID,
                DCS,
                DSR_REQ,
                PRIORITY,
                CONCAT_INFO,
                CLIENT_ID,
                SUBS_TYPE,
                APP_NUM,
                VALIDITY_PERIOD,
                DIALLED_NUM,
                ROUTING_TYPE,
                NODE_ID,
                MAP_MESSAGE_ID,
            ) = line.rstrip().split(',')

            db.EVRSMAIN.insert_one({
                'SM_MAIN': [{
                    'SCTS': str(SCTS),
                    'SCMSGREF': str(SCMSGREF),
                    'RECORDTYPE': str(RECORDTYPE),
                    'CAUSE': str(CAUSE),
                    'EVENT': str(EVENT),
                    'LOGGINGTIME': str(LOGGINGTIME),
                    'ACCESSMETHOD': str(ACCESSMETHOD),
                    'SMORIGADDR': str(SMORIGADDR),
                    'SMDESTADDR': str(SMDESTADDR),
                    'DISPLAYADDRVALUE': str(DISPLAYADDRVALUE),
                    'ORIGADDR_TYPE': str(ORIGADDR_TYPE),
                    'DESTADDR_TYPE': str(DESTADDR_TYPE),
                    'ORIG_IMSI': str(ORIG_IMSI),
                    'ORIG_VMSC': str(ORIG_VMSC),
                    'MSG_LEN': str(MSG_LEN),
                    'PID': str(PID),
                    'DCS': str(DCS),
                    'DSR_REQ': str(DSR_REQ),
                    'PRIORITY': str(PRIORITY),
                    'CONCAT_INFO': str(CONCAT_INFO),
                    'CLIENT_ID': str(CLIENT_ID),
                    'SUBS_TYPE': str(SUBS_TYPE),
                    'APP_NUM': str(APP_NUM),
                    'VALIDITY_PERIOD': str(VALIDITY_PERIOD),
                    'DIALLED_NUM': str(DIALLED_NUM),
                    'ROUTING_TYPE': str(ROUTING_TYPE),
                    'NODE_ID': str(NODE_ID),
                }]
            })


for file_ in smMainDetailAllFiles:
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
             MAP_MESSAGE_IDD,
             ) = line.rstrip().split(',')

            db.EVRSMDETAIL.insert_one({
                'MAP_MESSAGE_ID': str(MAP_MESSAGE_IDD),
                'SM_DETAIL': [{
                    'SCTS': str(SCTS),
                    'SCMSGREF': str(SCMSGREF),
                    'RECORDTYPE': str(RECORDTYPE),
                    'CAUSE': str(CAUSE),
                    'EVENT': str(EVENT),
                    'LOGGINGTIME': str(LOGGINGTIME),
                    'DEST_IMSI': str(DEST_IMSI),
                    'DEST_VMSCADDR': str(DEST_VMSCADDR),
                    'NUMOFDELATTEMPTS': str(NUMOFDELATTEMPTS),
                    'ACCESSMETHOD': str(ACCESSMETHOD),
                    'SMORIGADDR': str(SMORIGADDR),
                    'APP_NUM': str(APP_NUM),
                    'SMDESTADDR': str(SMDESTADDR),
                    'ROUTING_TYPE': str(ROUTING_TYPE),
                    'NODE_ID': str(NODE_ID)
                }]

print  "before insertion"
'''
db.EVR.insert_one({
    'SM_DETAIL': [{
        'SCTS': str(SCTS),
        'SCMSGREF': str(SCMSGREF),
        'RECORDTYPE': str(RECORDTYPE),
        'CAUSE': str(CAUSE),
        'EVENT': str(EVENT),
        'LOGGINGTIME': str(LOGGINGTIME),
        'DEST_IMSI': str(DEST_IMSI),
        'DEST_VMSCADDR': str(DEST_VMSCADDR),
        'NUMOFDELATTEMPTS': str(NUMOFDELATTEMPTS),
        'ACCESSMETHOD': str(ACCESSMETHOD),
        'SMORIGADDR': str(SMORIGADDR),
        'APP_NUM': str(APP_NUM),
        'SMDESTADDR': str(SMDESTADDR),
        'ROUTING_TYPE': str(ROUTING_TYPE),
        'NODE_ID': str(NODE_ID),
    }],
    'SM_MAIN': [{
        'SCTS': str(SCTS),
        'SCMSGREF': str(SCMSGREF),
        'RECORDTYPE': str(RECORDTYPE),
        'CAUSE': str(CAUSE),
        'EVENT': str(EVENT),
        'LOGGINGTIME': str(LOGGINGTIME),
        'ACCESSMETHOD': str(ACCESSMETHOD),
        'SMORIGADDR': str(SMORIGADDR),
        'SMDESTADDR': str(SMDESTADDR),
        'DISPLAYADDRVALUE': str(DISPLAYADDRVALUE),
        'ORIGADDR_TYPE': str(ORIGADDR_TYPE),
        'DESTADDR_TYPE': str(DESTADDR_TYPE),
        'ORIG_IMSI': str(ORIG_IMSI),
        'ORIG_VMSC': str(ORIG_VMSC),
        'MSG_LEN': str(MSG_LEN),
        'PID': str(PID),
        'DCS': str(DCS),
        'DSR_REQ': str(DSR_REQ),
        'PRIORITY': str(PRIORITY),
        'CONCAT_INFO': str(CONCAT_INFO),
        'CLIENT_ID': str(CLIENT_ID),
        'SUBS_TYPE': str(SUBS_TYPE),
        'APP_NUM': str(APP_NUM),
        'VALIDITY_PERIOD': str(VALIDITY_PERIOD),
        'DIALLED_NUM': str(DIALLED_NUM),
        'ROUTING_TYPE': str(ROUTING_TYPE),
        'NODE_ID': str(NODE_ID),
    }],
    'SR_DETAIL': [{
        'SCTS': str(SCTS),
        'SCMSGREF': str(SCMSGREF),
        'CAUSE': str(CAUSE),
        'EVENT': str(EVENT),
        'ACCESSMETHOD': str(ACCESSMETHOD),
        'SRORIGADDR': str(SRORIGADDR),
        'SRDESTADDR': str(SRDESTADDR),
        'LOGGINGTIME': str(LOGGINGTIME),
        'NODE_ID': str(NODE_ID),
    }],
    'SR_MAIN': [{
        'SCTS': str(SCTS),
        'SCMSGREF': str(SCMSGREF),
        'SRORIGADDR': str(SRORIGADDR),
        'SRDESTADDR': str(SRDESTADDR),
        'MSGID': str(MSGID),
        'SR_SCTS': str(SR_SCTS),
        'SM_STATUS': str(SM_STATUS),
        'SM_ERRCODE': str(SM_ERRCODE),
        'CAUSE': str(CAUSE),
        'EVENT': str(EVENT),
        'ACCESSMETHOD': str(ACCESSMETHOD),
        'DIALLED_NUM': str(DIALLED_NUM),
        'LOGGINGTIME': str(LOGGINGTIME),
        'NODE_ID': str(NODE_ID),
    }],
})

print "after insertion"



'''