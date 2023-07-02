unit uITanque;

interface

uses
  Data.DB, uTanque;

type
  ITanque = interface
    ['{0EE818C8-E3E3-4CC0-99C2-6EC84C13BA17}']
    procedure Salvar(Tanque: TTanque; Id: Integer = 0);
    function ListaTanques(Nome: String = ''): TDataSource;
    procedure ListaTanquePorId(Id: Integer);
    function Editar(Id: Integer): TDataSource;
    procedure Excluir(Id: Integer);
    function RetornaTanquePorId(Id: Integer): TTanque;
    function RetornaNomeTanque(Id: Integer): String;
  end;
implementation

end.
