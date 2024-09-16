from tkinter import messagebox
import funcoes_geracao

def criar_fatos_alunos_DSI():
    try:
        funcoes_geracao.criarFatosAlunos_DSI()
        messagebox.showinfo("Sucesso", "Fatos dos alunos DSI criados com sucesso!")
    except Exception as e:
        messagebox.showerror("Erro", f"Ocorreu um erro: {e}")

def criar_fatos_professores_DSI():
    try:
        funcoes_geracao.criarFatosProfessores_DSI()
        messagebox.showinfo("Sucesso", "Fatos dos professores DSI criados com sucesso!")
    except Exception as e:
        messagebox.showerror("Erro", f"Ocorreu um erro: {e}")

def criar_fatos_alunos_DCOMP():
    try:
        funcoes_geracao.criarFatosAlunos_DCOMP()
        messagebox.showinfo("Sucesso", "Fatos dos alunos DCOMP criados com sucesso!")
    except Exception as e:
        messagebox.showerror("Erro", f"Ocorreu um erro: {e}")

def criar_fatos_professores_DCOMP():
    try:
        funcoes_geracao.criarFatosProfessores_DCOMP()
        messagebox.showinfo("Sucesso", "Fatos dos professores DCOMP criados com sucesso!")
    except Exception as e:
        messagebox.showerror("Erro", f"Ocorreu um erro: {e}")
