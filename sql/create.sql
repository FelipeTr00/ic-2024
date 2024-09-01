CREATE TABLE rais_estab (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ano INTEGER,
    id_municipio INTEGER,
    quantidade_vinculos_ativos INTEGER,
    quantidade_vinculos_clt INTEGER,
    quantidade_vinculos_estatutarios INTEGER,
    tamanho_estabelecimento TEXT,
    tipo_estabelecimento TEXT,
    indicador_simples INTEGER,
    indicador_atividade_ano INTEGER,
    cnae_1 TEXT,
    cnae_1_descricao TEXT,
    cnae_1_descricao_grupo TEXT,
    cnae_1_descricao_divisao TEXT,
    cnae_1_descricao_secao TEXT,
    subsetor_ibge TEXT,
    FOREIGN KEY (id_municipio) REFERENCES ibge_municipios(id_municipio)
);

CREATE TABLE ibge_municipios (
    id_municipio INTEGER PRIMARY KEY,
    ano INTEGER,
    nome_municipio TEXT,
    sigla_uf TEXT,
    sigla_uf_nome TEXT,
    populacao INTEGER
);

CREATE TABLE municipios (
    id_municipio INTEGER PRIMARY KEY,
    id_municipio_nome TEXT,
    sigla_uf TEXT,
    sigla_uf_nome TEXT,
    ano INTEGER,
    populacao INTEGER

);

select * from rais_estab
where cnae_1_descricao is not null;

select * from municipios;