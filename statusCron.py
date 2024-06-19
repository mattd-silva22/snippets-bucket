import subprocess
from datetime import datetime


def checkServiceStatus(name):
    try:
        result = subprocess.run(
            ["systemctl", "status", name],
            capture_output=True,
            text=True,
            check=True
        )
       
        if "active (running)" in result.stdout:
            status = "running"
        elif "inactive (dead)" in result.stdout:
            status = "stopped"
        else:
            status = "unknown"

        

        return f"{name} is {status}\n"
        

    
    except Exception as e:
        return f"{name} is unknown. Error on checking status\n"

        


def saveStatusInLog(log, path):
    with open(path, "a") as file:
        file.write(f"{datetime.now()} - {log}\n")



def main():
    LOG_PATH = "/home/username/status.log"
    SERVICES = ["apache2", "mysql", "postgresql"]

    for service in SERVICES:
        log = checkServiceStatus(service)
        saveStatusInLog(log, LOG_PATH)

main()

