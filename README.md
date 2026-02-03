# SDBD2---Projeto-INEP

Projeto destinado a disciplina sistemas de banco de dados 2 de verão de 2026

## Equipe (Grupo 07)

| Nome                            | Matrícula   |
| -----------------------------   | ----------- |
| Caio Mesquita Vieira            | 220224283   |
| Ciro Costa de Araujo            | 190011611   |
| Emivalto da Costa Tavares Junior| 190091703   |
| Gabriel Bastos Bertolazi        | 202023663   |
| Letícia Torres Soares Martins   | 202016702   |

**Professor:** Thiago Luiz de Souza Gomes

---

## Como Executar o Projeto

Siga os passos abaixo para configurar o ambiente e executar os notebooks Jupyter.

**Pré-requisitos:**

* Python 3.12.3 ou superior.

**Passos:**

1. **Clone o repositório:**

    ```bash
    git clone <URL_DO_SEU_REPOSITORIO>
    cd <NOME_DO_DIRETORIO>
    ```

2. **Crie e ative um ambiente virtual (venv):**

    ```bash
    # Cria a venv no diretório '.venv'
    python3 -m venv .venv

    # Ativa a venv (Linux/macOS)
    source venv/bin/activate
    ```

    *Para Windows, use: `\venv\Scripts\activate`*

3. **Instale as dependências:**

    ```bash
    # O arquivo requirements.txt contém todas as bibliotecas necessárias
    pip3 install -r requirements.txt
    ```

    Se de errado tente esse outro comadno

    ```bash
    # O arquivo requirements.txt contém todas as bibliotecas necessárias
    python3 -m pip install -r requirements.txt
    ```

     Se de errado os dois acima 

    ```bash
    # O arquivo requirements.txt contém todas as bibliotecas necessárias
    ./.venv/bin/pip install -r requirements.txt
    ```

4. **Inicie o Jupyter Lab:**

    ```bash
    # O comando abrirá uma aba no seu navegador padrão
    jupyter lab
    ```

5. **Para encerrar:**

    * Feche o Jupyter Lab pressionando `Ctrl+C` no terminal.
    * Desative o ambiente virtual com o comando:

    ```bash
     deactivate 
     ```

6. ## Cria a pasta de plugins do Docker (se não existir)

    ``` bash
        mkdir -p ~/.docker/cli-plugins/
    ```

7. ## Baixa a versão estável mais recente do Docker Compose

    ``` bash
     curl -SL https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
     ```

8. ## Dá permissão de execução para o arquivo

    ``` bash
     chmod +x ~/.docker/cli-plugins/docker-compose
     ```
