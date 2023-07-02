unit uIValores;

interface

uses
  uValores, Data.DB;

type

  IValores = interface
    ['{930382CE-FA2E-4E8D-95DA-4E3F4B54FDFB}']
    procedure Salvar(Valores: TValores);
    function ListaValores(): TDataSource;
  end;

implementation

end.
