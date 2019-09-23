import telegram
import logging
import json
from flask import Flask
from flask import request
from flask_basicauth import BasicAuth

app = Flask(__name__)
app.secret_key = 'aYT>.L$kk2h>!'
app.config['BASIC_AUTH_USERNAME'] = ''
app.config['BASIC_AUTH_PASSWORD'] = ''

basic_auth = BasicAuth(app)
app.config['BASIC_AUTH_FORCE'] = True
bot = telegram.Bot(token="927656742:AAGS5yTPl46Dg08BBoYYgDHWXOgKO3cg7jk")
chatID = "-318201448"

@app.route('/alert', methods = ['POST'])
def postAlertmanager():

    content = json.loads(request.get_data())
    with open("Output.txt", "w") as text_file:
        text_file.write("{0}".format(content))
    try:

        for alert in content['alerts']:

            if 'name' in alert['labels']:

                message = """
Status """+alert['status']+"""
Alertname: """+alert['labels']['alertname']+"""
Instance: """+alert['labels']['instance']+"""("""+alert['labels']['name']+""")
"""+alert['annotations']['description']+"""
"""
            else:
                message = """
Status """+alert['status']+"""
Alertname: """+alert['labels']['alertname']+"""
Instance: """+alert['labels']['instance']+"""
"""+alert['annotations']['description']+"""
"""
            bot.sendMessage(chat_id=chatID,text=message)
            return "Alert OK", 200
    except:
        bot.sendMessage(chat_id=chatID,text="Failed to send via Flask to Telegram!")
        return "Alert nOK", 200

if __name__ == '__main__':
    logging.basicConfig(filename='flaskAlert.log',level=logging.INFO)
    app.run(host='0.0.0.0', port=9119)
