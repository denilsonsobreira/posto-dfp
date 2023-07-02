unit uIAbastecimento;

interface

uses
  Data.DB;

type

  IAbastecimento = interface
    ['{C96EF7DA-DE4F-47E7-A3FB-C94BDE476067}']
    function ListaBombasETipos(NomeBomba: String = ''): TDataSource;
  end;

implementation

end.
