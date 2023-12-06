USE trackware;

CREATE TABLE situacao (
    idSituacao INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    descricao VARCHAR(200)
);

INSERT INTO situacao (nome, descricao) VALUES
    ('Ativo', 'Funcionando'),
    ('Inativo', 'Parado mas não deletado'),
    ('Cancelado', 'Não irá mais continuar');

CREATE TABLE endereco (
    idEndereco INT PRIMARY KEY IDENTITY(1,1),
    CEP CHAR(8),
    rua VARCHAR(100),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    estado CHAR(2)
);

INSERT INTO endereco (CEP, rua, bairro, cidade, estado) VALUES
    ('03111100', 'Catabimbas da Criatividade', 'Lá longe', 'FIM do mundo', 'FM');

CREATE TABLE complemento (
    idComplemento INT PRIMARY KEY IDENTITY(1,1),
    fkEndereco INT,
    numero VARCHAR(10),
    complemento VARCHAR(45),
    CONSTRAINT FK_complemento_endereco FOREIGN KEY (fkEndereco) REFERENCES endereco (idEndereco)
);

INSERT INTO complemento (fkEndereco, numero, complemento) VALUES
    (1, '2435', 'Predio bem grande');

CREATE TABLE plano (
    idPlano INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    limite INT
);

INSERT INTO plano (nome, limite) VALUES
    ('Gratis', 5),
    ('Purple', 50),
    ('Black', 9999),
    ('Teste', 10);

CREATE TABLE tokens (
    idToken INT PRIMARY KEY IDENTITY(1,1),
    chaveAtivacao CHAR(15),
    fkSituacao INT,
    CONSTRAINT FK_tokens_situacao FOREIGN KEY (fkSituacao) REFERENCES situacao(idSituacao)
);

INSERT INTO tokens (chaveAtivacao, fkSituacao) VALUES
    ('123451234512345', 1);

CREATE TABLE tipoCartao (
    idTipoCartao INT PRIMARY KEY IDENTITY(1,1),
    tipo VARCHAR(45)
);
    
insert into tipoCartao(tipo) values
	('Debito'),
	('Credito')
    ;

CREATE TABLE bandeiraCartao (
    idBandeira INT PRIMARY KEY IDENTITY(1,1),
    bandeira VARCHAR(45)
);

INSERT INTO bandeiraCartao (bandeira) VALUES
    ('MasterCard'),
    ('Visa'),
    ('Maestro');



CREATE TABLE cartao (
    idCartao INT PRIMARY KEY IDENTITY(1,1),
    nomeTitular VARCHAR(45),
    numero CHAR(16),
    dtExpiracao DATE,
    numSeguranca VARCHAR(4),
    fkTipoCartao INT,
    fkBandeiraCartao INT,
    FOREIGN KEY (fkTipoCartao) REFERENCES tipoCartao(idTipoCartao),
    FOREIGN KEY (fkBandeiraCartao) REFERENCES bandeiraCartao(idBandeira)
);



INSERT INTO cartao (nomeTitular, numero, dtExpiracao, numSeguranca, fkTipoCartao, fkBandeiraCartao) VALUES
    ('Jose Maria João da Rosa', '1234567899876543', '2025-08-08', '123', 2, 1);

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(50),
    CNPJ CHAR(15),
    fkEnderecoComplemento INT,
    fkPlano INT,
    fkToken INT,
    fontePagamento INT,
    FOREIGN KEY (fkEnderecoComplemento) REFERENCES complemento (idComplemento),
    FOREIGN KEY (fkPlano) REFERENCES plano(idPlano),
    FOREIGN KEY (fkToken) REFERENCES tokens(idToken),
    FOREIGN KEY (fontePagamento) REFERENCES cartao(idCartao)
);

INSERT INTO empresa (nome, CNPJ, fkEnderecoComplemento, fkPlano, fkToken, fontePagamento) VALUES
    ('Encomendas do Zé', '123456543279813', 1, 4, 1, 1);

CREATE TABLE cargo (
    idCargo INT PRIMARY KEY IDENTITY(1,1),
    fkEmpresa INT,
    nome VARCHAR(45),
    funcao VARCHAR(200),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO cargo (fkEmpresa, nome, funcao) VALUES
    (1, 'Representante Empresa', 'Gerenciar tudo sobre o projeto');

CREATE TABLE permissao (
    idPermissao INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    descricao VARCHAR(200)
);

INSERT INTO permissao (nome, descricao) VALUES
    ('Acessar Histórico', 'O que ela faz'),
    ('Adicionar Cargos e Funcionarios', 'O que ela faz'),
    ('Editar Planos', 'O que ela faz'),
    ('Visualizar', 'O que ela faz');

CREATE TABLE permissionamento (
    idPermissionamento INT PRIMARY KEY IDENTITY(1,1),
    fkCargo INT,
    fkPermissao INT,
    permitido BIT,
    FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo),
    FOREIGN KEY (fkPermissao) REFERENCES permissao(idPermissao)
);

INSERT INTO permissionamento (fkCargo, fkPermissao, permitido) VALUES
    (1, 1, 1),
    (1, 2, 1),
    (1, 3, 1),
    (1, 4, 1);

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(30),
    sobrenome VARCHAR(100),
    CPF CHAR(11),
    email_Corporativo VARCHAR(80),
    senha VARCHAR(45),
    fkCargo INT,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo)
);

INSERT INTO usuario (nome, sobrenome, CPF, email_Corporativo, senha, fkCargo, fkEmpresa) VALUES
    ('Nathan', 'Oliveira', '12345678123', 'nathan@sptech.com', '12345678', 1, 1),
    ('Gustavo', 'Albino', '12345678123', 'gustavo@sptech.com', '12345678', 1, 1),
    ('Cesar', 'Martins', '12345678123', 'cesar@sptech.com', '12345678', 1, 1),
    ('Everton', 'Araujo', '12345678123', 'everton@sptech.com', '12345678', 1, 1),
    ('Giovanna', 'Avila', '12345678123', 'giovanna@sptech.com', '12345678', 1, 1);

CREATE TABLE tipoTelefone (
    idTipo INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    digitos INT
);

INSERT INTO tipoTelefone (nome, digitos) VALUES
    ('Celular', 11),
    ('Fixo', 10),
    ('Ramal', 3);

CREATE TABLE telefone (
    idTelefone INT PRIMARY KEY IDENTITY(1,1),
    fkUsuario INT,
    fkTipo INT,
    numero VARCHAR(11),
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkTipo) REFERENCES tipoTelefone(idTipo)
);



CREATE TABLE dispositivo (
    idDispositivo INT PRIMARY KEY IDENTITY(1,1),
    sistema_Operacional VARCHAR(45),
    IP VARCHAR(50),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
	alias varchar(50)
);



CREATE TABLE logs (
    idLog INT PRIMARY KEY IDENTITY(1,1),
    descricao VARCHAR(200)
);

INSERT INTO logs (descricao) VALUES
    ('iniciou o programa'),
    ('desativou o programa'),
    ('etc Logs'),
    ('adicionou um Usuario'),
    ('removeu um Usuario');

CREATE TABLE acesso (
    idAcesso INT PRIMARY KEY IDENTITY(1,1),
    fkUsuario INT,
    fkDispositivo INT,
    dtHora DATETIME DEFAULT GETDATE(),
    fkLog INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo),
    FOREIGN KEY (fkLog) REFERENCES logs(idLog)
);

CREATE TABLE unidadeMedida (
    idUnidadeMedida INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    descricao VARCHAR(200)
);

INSERT INTO unidadeMedida (nome, descricao) VALUES
    ('Porcentagem', 'Usado como medida de volume indica que o total foi dividido por 100 e aquilo é tantas partes daquela divisão'),
    ('Unidade', 'Usado como medida unitária'),
    ('hertz', 'Usado como medida na informática de velocidade mas é uma medida de frequência'),
    ('Gigahertz', 'Usado como medida na informática de velocidade mas é uma medida de frequência, é equivalente a 10^9 hertz'),
    ('bytes', 'Usado como medida de transferência de dados'),
    ('Gigabytes', 'Usado como medida de transferência de dados, equivalente a 10^9 bytes'),
    ('Megabytes', 'Usado como medida de transferência de dados, equivalente a 10^6 bytes');

CREATE TABLE tipoLimite (
    idTipoLimite INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    descricao VARCHAR(200)
);

INSERT INTO tipoLimite (nome, descricao) VALUES
    ('Alerta Vermelho', 'Deu ruim cara, tem que ver urgente isso aí'),
    ('Alerta Amarelo', 'Cara, fica de olho, por favor');

CREATE TABLE gatilhos (
    idGatilhos INT PRIMARY KEY IDENTITY(1,1),
    limite FLOAT,
    fkTipoLimite INT,
    FOREIGN KEY (fkTipoLimite) REFERENCES tipoLimite(idTipoLimite)
);

INSERT INTO gatilhos (limite, fkTipoLimite) VALUES
    (80, 1),
    (90, 1),
    (70, 2),
    (60, 2),
    (50, 2),
    (95, 1),
    (75, 1);

CREATE TABLE tipoComponente (
    idTipoComponente INT PRIMARY KEY IDENTITY(1,1),
    nome VARCHAR(45),
    descricao VARCHAR(200),
    fkUnidadeMedida INT,
    FOREIGN KEY (fkUnidadeMedida) REFERENCES unidadeMedida(idUnidadeMedida)
);

INSERT INTO tipoComponente (nome, descricao, fkUnidadeMedida) VALUES
    ('CPU', 'Um componente do escopo', 1),
    ('Memória', 'Um componente do escopo', 1),
    ('Disco', 'Um componente do escopo', 1),
    ('USB', 'Um componente do escopo', 4),
    ('JanelasAbertas', 'Um componente do escopo', 2),
    ('Rede(recebida)', 'Um componente do escopo', 3),
    ('Rede(enviada)', 'Um componente do escopo', 3);

CREATE TABLE Monitorar (
    idMonitorar INT PRIMARY KEY IDENTITY(1,1),
    fkPlano INT,
    fkTipoComponente INT,
    permissao BIT,
    FOREIGN KEY (fkPlano) REFERENCES plano(idPlano),
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente)
);

INSERT INTO Monitorar (fkPlano, fkTipoComponente, permissao) VALUES
    (1, 1, 1),
    (1, 2, 1),
    (1, 3, 1),
    (1, 4, 0),
    (1, 5, 0),
    (1, 6, 0),
    (2, 1, 1),
    (2, 2, 1),
    (2, 3, 1),
    (2, 4, 1),
    (2, 5, 0),
    (2, 6, 0),
    (3, 1, 1),
    (3, 2, 1),
    (3, 3, 1),
    (3, 4, 1),
    (3, 5, 1),
    (3, 6, 1),
    (4, 1, 1),
    (4, 2, 1),
    (4, 3, 1),
    (4, 4, 1),
    (4, 5, 1),
    (4, 6, 1);

CREATE TABLE componentes (
    idComponente INT PRIMARY KEY IDENTITY(1,1),
    fkTipoComponente INT,
    fkDispositivo INT,
    capacidade FLOAT,
    fkGatilhos INT,
    FOREIGN KEY (fkTipoComponente) REFERENCES tipoComponente(idTipoComponente),
    FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo),
    FOREIGN KEY (fkGatilhos) REFERENCES gatilhos(idGatilhos)
);

CREATE TABLE monitoramento (
    idDado INT PRIMARY KEY IDENTITY(1,1),
    dadoCapturado FLOAT,
    dtHora DATETIME DEFAULT GETDATE(),
    fkComponente INT,
    fkDispositivo INT,
    FOREIGN KEY (fkComponente) REFERENCES componentes(idComponente),
    FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo)
);

CREATE TABLE alerta (
    idAlerta INT PRIMARY KEY IDENTITY(1,1),
    fkNivel INT,
    descricao VARCHAR(100),
    fkDados INT,
    fkComponente INT,
    FOREIGN KEY (fkNivel) REFERENCES tipoLimite(idTipoLimite),
    FOREIGN KEY (fkDados) REFERENCES monitoramento(idDado),
    FOREIGN KEY (fkComponente) REFERENCES componentes(idComponente)
);

CREATE TABLE processosBloqueados (
    idProcesso INT PRIMARY KEY IDENTITY(1,1),
    fkEmpresa INT,
    nome VARCHAR(45),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

insert into processosBloqueados(fkEmpresa,nome) values
	(1, 'idea64');

CREATE TABLE ocorrencias (
    idOcorrencias INT PRIMARY KEY IDENTITY(1,1),
    fkProcesso INT,
    fkDispositivo INT,
	cpu float,
    dtHora DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (fkProcesso) REFERENCES processosBloqueados(idProcesso),
    FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo)
);
CREATE TABLE geolocalizacao (
    idGeolocalizacao INT PRIMARY KEY IDENTITY(1,1),
    endereco VARCHAR(200),
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    data_atual DATETIME DEFAULT GETDATE(),
	hora_atual DATETIME DEFAULT GETDATE(),
    fkDispositivo INT,
    FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo)
);

CREATE TABLE dados_cpu (
    idDadosCPU INT PRIMARY KEY IDENTITY(1,1),
    nomeCPU VARCHAR(200),
    porcentagemUsoCPU FLOAT,
    dataHoraCaptura DATETIME,
    fkDispositivo INT,
    FOREIGN KEY (fkDispositivo) REFERENCES dispositivo(idDispositivo)
);