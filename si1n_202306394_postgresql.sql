-- TURMA: SI1N / / MATRÍCULA: 202306394 / / NOME: KEVIN FELISBERTO DA SILVA


DROP DATABASE IF EXISTS uvv;

-- EXCLUI O DATABASE uvv, SE EXISTENTE

DROP ROLE IF EXISTS kevin;

-- EXCLUI O USUÁRIO kevin, SE EXISTENTE

CREATE USER kevin WITH ENCRYPTED PASSWORD 'kevin3210' CREATEDB CREATEROLE; 

-- CRIA UM USUÁRIO kevin COM A SENHA CRIPTOGRAFADA 'kevin3210' E COM PERMISSÕES DE CRIAR BANCO DE DADOS E CRIAR USUÁRIOS

CREATE DATABASE uvv WITH

-- CRIAR database uvv

OWNER kevin

-- TENDO COMO DONO kevin

TEMPLATE 'template0'

-- TENDO COMO MODELO A PARTIR DO QUAL CRIAR O BANCO DE DADOS template0

ENCODING 'UTF8'

-- TENDO COMO CODIFICAÇÃO DO CONJUNTO DE CARACTERES UTF8

LC_COLLATE 'pt_BR.UTF-8'

-- TENDO COMO ORDEM DE AGRUPAMENTO pt_BR.UTF-8

LC_CTYPE 'pt_BR.UTF-8'

-- TENDO COMO CLASSIFICAÇÃO DE CARACTERES pt_BR.UTF-8

ALLOW_CONNECTIONS = TRUE;

-- PERMITINDO CONEXÕES A ESTE BANCO DE DADOS

GRANT ALL PRIVILEGES ON DATABASE uvv TO kevin;

-- PERMITIR TODOS OS PRIVILÉGIOS DO BANCO DE DADOS uvv PARA O USUÁRIO kevin

\c "dbname=uvv user=kevin password=kevin3210"

-- TROCANDO A CONEXÃO

CREATE SCHEMA lojas AUTHORIZATION kevin;

-- CRIANDO O SCHEMA lojas

SELECT current_schema();

-- VER O ESQUEMA PADRÃO

SHOW SEARCH_PATH;

-- VER O PARÂMETRO SEARCH_PATH

SET SEARCH_PATH TO lojas, "$user", public;

-- SELECIONANDO COMO ESQUEMA lojas

SHOW SEARCH_PATH;

-- CONFIRMANDO SE O ESQUEMA lojas APARECE NA FRENTE DE TODOS E SE TORNOU-SE PADRÃO

ALTER USER kevin
SET SEARCH_PATH TO lojas, "$user", public;

-- TORNANDO O ESQUEMA lojas COMO PADRÃO PERMANENTEMENTE

CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_id PRIMARY KEY (produto_id)
                -- TORNAR A COLUNA produtos_id UMA PK DA TABELA produtos
);
COMMENT ON TABLE produtos IS 'tabela de criação de produtos';
COMMENT ON COLUMN produtos.produto_id IS 'coluna de id do produto';
COMMENT ON COLUMN produtos.nome IS 'coluna de nome do produto';
COMMENT ON COLUMN produtos.preco_unitario IS 'coluna de preço unitário do produto';
COMMENT ON COLUMN produtos.detalhes IS 'coluna de detalhes do produto';
COMMENT ON COLUMN produtos.imagem IS 'coluna de imagem do produto';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'coluna de tipo de arquivo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'coluna de arquivo da imagem do produto';
COMMENT ON COLUMN produtos.imagem_charset IS 'coluna de charset da imagem do produto';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'coluna de data da ultima atualização da imagem do produto';


CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_id PRIMARY KEY (cliente_id)
                -- TORNAR A COLUNA clientes_id UMA PK DA TABELA clientes
);
COMMENT ON TABLE clientes IS 'tabela de criação dos clientes';
COMMENT ON COLUMN clientes.cliente_id IS 'coluna de id do cliente';
COMMENT ON COLUMN clientes.email IS 'coluna de email do cliente';
COMMENT ON COLUMN clientes.nome IS 'coluna de nome do cliente';
COMMENT ON COLUMN clientes.telefone1 IS 'coluna de número de telefone do cliente';
COMMENT ON COLUMN clientes.telefone2 IS 'coluna de segundo número de telefone do cliente';
COMMENT ON COLUMN clientes.telefone3 IS 'coluna de terceiro número de telefone do cliente';


CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
                -- TORNAR A COLUNA loja_id UMA PK DA TABELA lojas
);
COMMENT ON TABLE lojas IS 'tabela de criação das lojas';
COMMENT ON COLUMN lojas.loja_id IS 'coluna de id da loja';
COMMENT ON COLUMN lojas.nome IS 'coluna de nome da loja';
COMMENT ON COLUMN lojas.endereco_web IS 'coluna de endereço web da loja';
COMMENT ON COLUMN lojas.endereco_fisico IS 'coluna de endereço físico da loja';
COMMENT ON COLUMN lojas.latitude IS 'coluna de informar a latitude da localidade da loja';
COMMENT ON COLUMN lojas.longitude IS 'coluna de informar a longitude da localidade da loja';
COMMENT ON COLUMN lojas.logo IS 'coluna de logo da loja';
COMMENT ON COLUMN lojas.logo_mime_type IS 'coluna de tipo de arquivo da logo da loja';
COMMENT ON COLUMN lojas.logo_arquivo IS 'coluna de arquivo da logo da loja';
COMMENT ON COLUMN lojas.logo_charset IS 'coluna de charset da logo da loja';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'coluna de data da ultima atualização da logo da loja';


CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
                -- TORNAR A COLUNA pedido_id UMA PK DA TABELA pedidos
);
COMMENT ON TABLE pedidos IS 'tabela de criação de pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 'coluna de id do pedido';
COMMENT ON COLUMN pedidos.data_hora IS 'coluna da data e hora em que o pedido foi feito';
COMMENT ON COLUMN pedidos.cliente_id IS 'coluna de id do cliente';
COMMENT ON COLUMN pedidos.status IS 'coluna de status do pedido';
COMMENT ON COLUMN pedidos.loja_id IS 'coluna de id da loja em que foi feito o pedido';


CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
                -- TORNAR A COLUNA envio_id UMA PK DA TABELA envios
);
COMMENT ON TABLE envios IS 'tabela de criação de envios';
COMMENT ON COLUMN envios.envio_id IS 'coluna de id do envio';
COMMENT ON COLUMN envios.loja_id IS 'coluna de id da loja que executa o envio';
COMMENT ON COLUMN envios.cliente_id IS 'coluna de id do cliente que vai receber o envio';
COMMENT ON COLUMN envios.endereco_entrega IS 'coluna de endereço de entrega do envio';
COMMENT ON COLUMN envios.status IS 'coluna de status do envio';


CREATE TABLE pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_id_produto_id PRIMARY KEY (pedido_id, produto_id)
                -- TORNAR AS COLUNAS pedido_id E produto_id PKs DA TABELA pedidos_itens
);
COMMENT ON TABLE pedidos_itens IS 'tabela de criação de itens e pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'coluna de id do pedido';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'coluna de id do produto';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'coluna de número da linha';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'coluna de preço unitário do produto';
COMMENT ON COLUMN pedidos_itens.quantidade IS 'coluna de quantidade';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'coluna de id do envio';


CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
                -- TORNAR A COLUNA estoque_id UMA PK DA TABELA estoques
);
COMMENT ON TABLE estoques IS 'tabela de criação de estoques';
COMMENT ON COLUMN estoques.estoque_id IS 'coluna de id do estoque';
COMMENT ON COLUMN estoques.loja_id IS 'coluna de id da loja da qual tem ou usa o estoque';
COMMENT ON COLUMN estoques.produto_id IS 'coluna de id do produto';
COMMENT ON COLUMN estoques.quantidade IS 'coluna de quantidade de produtos no estoque';


ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA produto_id DA TABELA produtos UMA FK NA TABELA estoques

ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA produto_id DA TABELA produtos UMA FK NA TABELA pedidos_itens

ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA cliente_id DA TABELA clientes UMA FK NA TABELA envios

ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA cliente_id DA TABELA clientes UMA FK NA TABELA pedidos

ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA loja_id DA TABELA lojas UMA FK NA TABELA estoques

ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA loja_id DA TABELA lojas UMA FK DA TABELA envios

ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA loja_id DA TABELA lojas UMA FK NA TABELA pedidos

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA pedido_id DA TABELA pedidos UMA FK NA TABELA pedidos_itens

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- TORNAR A COLUNA envio_id DA TABELA envios UMA FK NA TABELA pedidos_itens

ALTER TABLE produtos
ADD CONSTRAINT check_produto_id
CHECK(produto_id > 0);

-- O VALOR PREENCHIDO NA COLUNA produto_id DEVE SER MAIOR QUE 0

ALTER TABLE produtos
ADD CONSTRAINT check_preco_unitario
CHECK(preco_unitario >= 0);

-- O VALOR PREENCHIDO NA COLUNA preco_unitario DEVE SER MAIOR QUE 0

ALTER TABLE clientes
ADD CONSTRAINT check_cliente_id
CHECK(cliente_id > 0);

-- O VALOR PREENCHIDO NA COLUNA cliente_id DEVE SER MAIOR QUE 0

ALTER TABLE lojas
ADD CONSTRAINT check_loja_id
CHECK(loja_id > 0);

-- O VALOR PREENCHIDO NA COLUNA loja_id DEVE SER MAIOR QUE 0

ALTER TABLE pedidos
ADD CONSTRAINT check_pedido_id
CHECK(pedido_id > 0);

-- O VALOR PREENCHIDO NA COLUNA pedido_id DEVE SER MAIOR QUE 0

ALTER TABLE envios
ADD CONSTRAINT check_envio_id
CHECK(envio_id > 0);

-- O VALOR PREENCHIDO NA COLUNA envio_id DEVE SER MAIOR QUE 0

ALTER TABLE pedidos
ADD CONSTRAINT check_pedidos_status
CHECK(status IN('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

 -- A COLUNA PODE APENAS SER PREENCHIDA COM OS VALORES: CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO, ENVIADO

ALTER TABLE envios
ADD CONSTRAINT check_envios_status
CHECK(status IN('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

-- A COLUNA PODE APENAS SER PREENCHIDA COM OS VALORES: CRIADO, ENVIADO, TRANSITO, ENTREGUE

ALTER TABLE lojas
ADD CONSTRAINT check_endereco 
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

-- RESTRIÇÃO QUE GARANTA QUE PELO MENOS UMA DAS COLUNAS DE endereco (WEB OU FÍSICO) ESTEJA PREENCHIDA NA TABELA lojas
