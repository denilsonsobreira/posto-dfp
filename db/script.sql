/*Tabela TANQUE*/
CREATE TABLE TANQUE (
    ID INTEGER NOT NULL,
    NOME VARCHAR(40) NOT NULL,
    TIPO_COMBUSTIVEL INTEGER NOT NULL);

ALTER TABLE TANQUE
ADD CONSTRAINT PK_TANQUE
PRIMARY KEY (ID);

COMMENT ON COLUMN TANQUE.TIPO_COMBUSTIVEL IS
'(0)Gasolina; (1)Óleo diesel;';

CREATE SEQUENCE GEN_TANQUE_ID;

SET TERM ^ ;

create trigger tanque_bi for tanque
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_tanque_id,1);
end^

SET TERM ; ^

/*Tabela BOMBA*/
CREATE TABLE BOMBA (
    ID INTEGER NOT NULL,
    NOME VARCHAR(40) NOT NULL,
    TANQUE_ID INTEGER NOT NULL);

ALTER TABLE BOMBA
ADD CONSTRAINT PK_BOMBA
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_BOMBA_ID;

SET TERM ^ ;

create trigger bomba_bi for bomba
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_bomba_id,1);
end^

SET TERM ; ^

ALTER TABLE BOMBA
ADD CONSTRAINT FK_BOMBA_1
FOREIGN KEY (TANQUE_ID)
REFERENCES TANQUE(ID);


CREATE TABLE VALORES (
    ID INTEGER NOT NULL,
    VALOR_LITRO_GASOLINA NUMERIC(15,2) NOT NULL,
    VALOR_LITRO_OLEO_DIESEL NUMERIC(15,2) NOT NULL,
    VALOR_IMPOSTO NUMERIC(15,2) NOT NULL);

ALTER TABLE VALORES
ADD CONSTRAINT PK_VALORES
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_VALORES_ID;

SET TERM ^ ;

create trigger valores_bi for valores
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_valores_id,1);
end^

SET TERM ; ^

CREATE TABLE ABASTECIMENTO (
    ID INTEGER NOT NULL,
    LITROS NUMERIC(15,2) NOT NULL,
    VALOR_TOTAL NUMERIC(15,2) NOT NULL,
    IMPOSTO NUMERIC(15,2) NOT NULL,
    DATA DATE NOT NULL,
    BOMBA_ID INTEGER NOT NULL);

ALTER TABLE ABASTECIMENTO
ADD CONSTRAINT PK_ABASTECIMENTO
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_ABASTECIMENTO_ID;

SET TERM ^ ;

create trigger abastecimento_bi for abastecimento
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_abastecimento_id,1);
end^

SET TERM ; ^

