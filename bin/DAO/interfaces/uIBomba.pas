unit uIBomba;

interface

uses
  uBomba, Data.DB;

type
  IBomba = interface
    ['{6846B7AF-0517-4E93-B032-803DDB711267}']
    procedure Salvar(Bomba: TBomba; Id: Integer = 0);
    function ListaBombas(Nome: String = ''): TDataSource;
    procedure ListaBombaPorId(Id: Integer);
    function Editar(Id: Integer): TDataSource;
    procedure Excluir(Id: Integer);
  end;

implementation

end.
