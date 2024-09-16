import tkinter as tk
import funcoes_tela

root = tk.Tk()
root.title("Criar Fatos")

root.geometry("300x300")

btn_alunos_dsi = tk.Button(root, text="Criar Fatos Alunos - DSI", command=funcoes_tela.criar_fatos_alunos_DSI)
btn_alunos_dsi.pack(pady=10)

btn_professores_dsi = tk.Button(root, text="Criar Fatos Professores - DSI", command=funcoes_tela.criar_fatos_professores_DSI)
btn_professores_dsi.pack(pady=10)

btn_alunos_dcomp = tk.Button(root, text="Criar Fatos Alunos - DCOMP", command=funcoes_tela.criar_fatos_alunos_DCOMP)
btn_alunos_dcomp.pack(pady=10)

btn_professores_dcomp = tk.Button(root, text="Criar Fatos Professores - DCOMP", command=funcoes_tela.criar_fatos_professores_DCOMP)
btn_professores_dcomp.pack(pady=10)

# Iniciar a interface
root.mainloop()