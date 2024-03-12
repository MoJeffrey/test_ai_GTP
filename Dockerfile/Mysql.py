import traceback

import pymysql
from enum import Enum, unique

from loguru import logger
from pymysql import converters
from pymysql.connections import Connection
from pymysql.cursors import Cursor


@unique
class MysqlErrorType(Enum):
    # SQL 語句錯誤
    sql_error = 1
    # 改變數量錯誤
    rowcount_error = 2
    # 主鍵錯誤
    PRIMARY_Error = 3


class Mysql:
    conv = converters.conversions
    conv[246] = float

    connection: Connection = None
    cursor: Cursor = None
    # 錯誤日誌方法
    ErrorLogFunc = None

    # 重試次數
    __MaxReTryTime: int = 3
    __sql: str = None
    __error_type: int = None
    __msg: str = None
    __success: bool = None

    def __init__(self, sql: str):
        """
        """
        self.__sql = sql

    def get_msg(self) -> str:
        return self.__msg

    def get_sql(self) -> str:
        return self.__sql

    def get_success(self) -> bool:
        return self.__success

    def get_error_type(self) -> int:
        return self.__error_type

    @staticmethod
    def Init(HOST, Name, Password, DataBaseName):
        """
        初始化
        :return:
        """
        db = {
            "host": HOST,
            "user": Name,
            "password": Password,
            "database": DataBaseName,
            "conv": Mysql.conv
        }
        Mysql.connection = pymysql.connect(**db)
        Mysql.cursor = Mysql.connection.cursor(pymysql.cursors.DictCursor)
        return

    @staticmethod
    def Close():
        Mysql.connection.close()

    def exist(self) -> bool:
        """
        注*
        如果SQL語句包含多條
        只會檢查第一條SQL 結果
        :return:
        """
        Mysql.cursor.execute(self.__sql)
        Mysql.connection.commit()
        if Mysql.cursor.fetchone() is None:
            return False
        else:
            return True

    @staticmethod
    def CallProc(ProcName: str, Param: tuple) -> [bool, list]:
        """
        呼叫Mysql Proc
        重試 機制
        """
        Mysql.connection.ping()
        cursor = Mysql.connection.cursor()
        data = []

        for a in Param:
            data.append(a if a != "NULL" else None)

        cursor.callproc(ProcName, data)
        # logger.info(f'ProcName: {ProcName}, Param: {Param}')
        return cursor

    @staticmethod
    def dictFetchAll(cursor):
        desc = cursor.description
        return [
            dict(zip([col[0] for col in desc], row))
            for row in cursor.fetchall()
        ]
