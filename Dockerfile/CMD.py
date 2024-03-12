import json

import mysql.connector

from Mysql import Mysql
from config import config


class CMD(object):
    __config = None
    __args = None

    def __init__(self, args):
        self.__config = config()
        self.__args = args

    def SendError(self, msg):
        print(f'{self.__args[1]} NO {msg}')

    def SendOK(self, data):
        print(f'{self.__args[1]} OK {data}')

    def NoFunc(self):
        self.SendError('没有该工具')

    def Run(self):
        func = self.GetFunc()
        func()

    def ConnectDB(self):
        """
        连接数据库
        :return:
        """
        db_config = {
            'host': self.__args[2],
            'user': self.__args[3],
            'password': self.__args[4],
            'database': 'data_clean_setting',
        }

        try:
            # 连接到MySQL数据库
            conn = mysql.connector.connect(**db_config)

            # 创建一个游标对象来执行SQL语句
            cursor = conn.cursor()

            # 关闭连接
            cursor.close()
            conn.close()
        except mysql.connector.errors.ProgrammingError:
            print(f'{self.__args[1]} NO 密码错误')
            return
        except mysql.connector.errors.DatabaseError:
            print(f'{self.__args[1]} NO 无法连接数据库')
            return

        self.__config.Set(self.__args[2], self.__args[3], self.__args[4], 'data_clean_setting')
        print(f'{self.__args[1]} OK 连接成功')

    def CommonFunc(self, ProcName: str, Param: tuple):
        if not self.__config.isConnect():
            self.SendError('没有连接数据库')
            return

        Mysql.Init(*self.__config.Get())

        cursor = Mysql.CallProc(ProcName, Param)
        self.SendOK(Mysql.dictFetchAll(cursor))
        Mysql.Close()

    def GetFunc(self):
        Func = {
            "连接数据库": self.ConnectDB,
            "查询标准表": self.GetStandardTableList,
            "查看标准协议": self.GetStandardAgreement,
            "添加标准字段": self.CreateStandardField,
            "标准字段与标准表绑定": self.AddTableBindField,
            "目标数据表列表": self.GetTargetTableList,
            "目标数据表": self.GetTargetTableInfo,
            "建立标准表": self.Run_CreateStandardTable,
            "标准表与目标表绑定": self.AddStandardTableBindTargetTable,
            "标准表与目标表字段绑定": self.AddStandardFieldBindTargetField,
            "预览": self.GetPreview,
            "添加标准协议": self.CreateStandardAgreement,
            "查询标准表信息": self.GetStandardTableInfo
        }

        if self.__args[1] in Func:
            return Func[self.__args[1]]
        else:
            return self.NoFunc

    def Run_CreateStandardTable(self):
        self.CommonFunc('Run_CreateStandardTable', self.__args[2:])

    def CreateStandardAgreement(self):
        self.CommonFunc('CreateStandardAgreement', self.__args[2:])

    def GetPreview(self):
        """
        目标数据表列表
        :return:
        """
        self.CommonFunc('GetPreview', self.__args[2:])

    def AddStandardFieldBindTargetField(self):
        """
        目标数据表列表
        :return:
        """
        jsonData = {}
        data: str = self.__args[3].split(',')

        x = 0
        for field in data:
            jsonData[x] = field
            x += 1

        self.CommonFunc('AddStandardFieldBindTargetField', (self.__args[2], json.dumps(jsonData)))

    def AddStandardTableBindTargetTable(self):
        """
        目标数据表列表
        :return:
        """
        self.CommonFunc('AddStandardTableBindTargetTable', self.__args[2:])

    def GetTargetTableInfo(self):
        """
        目标数据表列表
        :return:
        """
        self.CommonFunc('GetTargetTableInfo', self.__args[2:])

    def GetTargetTableList(self):
        """
        目标数据表列表
        :return:
        """
        self.CommonFunc('GetTargetTableList', ())

    def AddTableBindField(self):
        """
        标准字段与标准表绑定
        :return:
        """
        self.CommonFunc('AddTableBindField', self.__args[2:])

    def GetStandardTableList(self):
        """
        查询标准表
        :return:
        """
        self.CommonFunc('GetStandardTableList', self.__args[2:])

    def GetStandardTableInfo(self):
        """
        查询标准库
        :return:
        """
        self.CommonFunc('GetStandardTableInfo', self.__args[2])

    def GetStandardAgreement(self):
        """
        查看标准协议
        :return:
        """
        self.CommonFunc('GetStandardAgreement', ())

    def CreateStandardField(self):
        """
        添加标准字段
        :return:
        """
        self.CommonFunc('CreateStandardField', self.__args[2:])
