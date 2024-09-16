import requests
from bs4 import BeautifulSoup

def criarFatosAlunos_DSI():
    url = 'https://sigaa.ufs.br/sigaa/public/curso/alunos.jsf?lc=pt_BR&id=320196'

    resposta = requests.get(url) #Método GET na URL

    soup = BeautifulSoup(resposta.content, 'html.parser') #Dada a reposta do GET, retorna o conteúdo da página HTML

    tabela = soup.find('table', class_='listagem') #Procura a linha listagem, onde estão os alunos

    linhas = tabela.find_all('tr')[1:] #Ignora o cabeçalho

    #Com o arquivo aberto, irá executar o código
    with open('alunos_DSI.pl', 'w', encoding='utf-8') as arquivo:
        for linha in linhas: #Com o cabeçalho ignorado, irá procurar os dados dos alunos
            try:
                matricula = linha.find('td', class_='colMatricula').text.strip() #Guarda em matrícula que está na classse colMatricula
                aluno = linha.find_all('td')[1].text.strip() #Vai para linha seguinte e guarda o nome do aluno
                arquivo.write(f'aluno("DISCENTE","{matricula}", "{aluno}", "DSI").\n') #Escreve no arquivo os dados dos alunos no formato de fatos, quebrando a linha a cada aluno.
            except:
                print("Tabela Finalizada.")

def criarFatosProfessores_DSI():
    url = 'https://www.sigaa.ufs.br/sigaa/public/departamento/professores.jsf?id=198'

    resposta = requests.get(url)

    soup = BeautifulSoup(resposta.content, 'html.parser')

    linhas = soup.find_all('tr')

    with open('professores_DSI.pl', 'w', encoding='utf-8') as arquivo:
        for linha in linhas:
            nome = linha.find('span', class_='nome').text.strip()
            nome = nome.replace('\n', '').replace('\t', '').strip()
            arquivo.write(f'professor("DOCENTE","{nome}", "DSI").\n')

def criarFatosAlunos_DCOMP():
    url = 'https://sigaa.ufs.br/sigaa/public/curso/alunos.jsf?lc=pt_BR&id=320197'

    resposta = requests.get(url) 

    soup = BeautifulSoup(resposta.content, 'html.parser')

    tabela = soup.find('table', class_='listagem')

    linhas = tabela.find_all('tr')[1:]

    with open('alunos_DCOMP.pl', 'w', encoding='utf-8') as arquivo:
        for linha in linhas:
            try:
                matricula = linha.find('td', class_='colMatricula').text.strip() 
                aluno = linha.find_all('td')[1].text.strip()
                arquivo.write(f'aluno("DISCENTE","{matricula}", "{aluno}", "DCOMP").\n')
            except:
                print("Tabela Finalizada.")

def criarFatosProfessores_DCOMP():
    url = 'https://www.sigaa.ufs.br/sigaa/public/departamento/professores.jsf?id=83'

    resposta = requests.get(url)

    soup = BeautifulSoup(resposta.content, 'html.parser')

    linhas = soup.find_all('tr')

    with open('professores_DCOMP.pl', 'w', encoding='utf-8') as arquivo:
        for linha in linhas:
            nome = linha.find('span', class_='nome').text.strip()
            nome = nome.replace('\n', '').replace('\t', '').strip()
            arquivo.write(f'professor("DOCENTE","{nome}", "DCOMP").\n')

