import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from dotenv import load_dotenv
import os

load_dotenv()

email = os.getenv("EMAIL")

def enviar_email():
    

    remetente = "email.teste.geren@gmail.com"
    destinatario = "hisham8597@uorak.com"
    
    assunto = "Envio de token de segurança para atualização da senha"
    
    corpo = """
    Prezado usuário,

    Caso você tenha esquecido sua senha tente atualizar a mesma utilizando o token informado.
    
    Atenciosamente,
    Equipe de Suporte
    """

    # Carregar a senha do arquivo .env
    senha = os.getenv("EMAIL_PASSWORD")

    # Configurando o servidor SMTP do Gmail
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()

    try:
        # Fazendo login no servidor SMTP usando a senha do arquivo .env
        server.login('email.teste.geren@gmail.com', senha)


        msg = MIMEMultipart()
        msg['From'] = remetente
        msg['To'] = destinatario
        msg['Subject'] = assunto
        msg.attach(MIMEText(corpo, 'plain'))

        server.sendmail(remetente, destinatario, msg.as_string())
        print("Email enviado com sucesso!")

    except Exception as e:
        print(f"Falha ao enviar email: {e}")

    finally:
        server.quit()

# Executar envio de phishing
enviar_email()