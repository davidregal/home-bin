from email.mime.text import MIMEText
from subprocess import Popen, PIPE

msg = MIMEText("Test. Body of my message")
msg["From"] = "sysadmin@techborder.com"
msg["To"] = "dvd.regal@gmail.com"
msg["Subject"] = "Test. Subject from server."
p = Popen(["/usr/sbin/sendmail", "-t"], stdin=PIPE)
p.communicate(msg.as_string())
