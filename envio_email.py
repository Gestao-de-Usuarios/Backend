import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from dotenv import load_dotenv
import os

load_dotenv()

email = os.getenv("EMAIL")

def enviar_email(destinatario, nova_senha):
    remetente = email
    assunto = "Sua Nova Senha"
    corpo = f"""
    Prezado usuário,

    Conforme solicitado, sua nova senha é: {nova_senha}

    Por favor, faça login com esta senha e altere-a imediatamente por motivos de segurança.

    Atenciosamente,
    Equipe de Suporte
    """

    # Carregar a senha do email do arquivo .env
    senha = os.getenv("EMAIL_PASSWORD")

    # Configurando o servidor SMTP do Gmail
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()

    try:
        # Fazendo login no servidor SMTP usando a senha do arquivo .env
        server.login(remetente, senha)

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
