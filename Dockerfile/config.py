import configparser


class config(object):

    __config = None

    def __init__(self):
        self.__config = configparser.ConfigParser()
        self.__config.read('config.ini')

    def isConnect(self):
        if 'Settings' in self.__config:
            return True
        return False

    def Set(self, HOST, Name, Password, DataBaseName):
        # 寫入配置信息
        self.__config['Settings'] = {
            'HOST': HOST,
            'Name': Name,
            'Password': Password,
            'DataBaseName': DataBaseName
        }

        # 寫入到文件
        with open('config.ini', 'w') as configfile:
            self.__config.write(configfile)

    def Get(self):
        HOST = self.__config['Settings']['HOST']
        Name = self.__config['Settings']['Name']
        Password = self.__config['Settings']['Password']
        DataBaseName = self.__config['Settings']['DataBaseName']
        return HOST, Name, Password, DataBaseName
