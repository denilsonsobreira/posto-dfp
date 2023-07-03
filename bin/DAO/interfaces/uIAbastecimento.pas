unit uIAbastecimento;

interface

uses
  Data.DB, uAbastecimento;

type

  IAbastecimento = interface
    ['{C96EF7DA-DE4F-47E7-A3FB-C94BDE476067}']
    procedure Salvar(Abastecimento: TAbastecimento);
    function ListaBombasETipos(NomeBomba: String = ''): TDataSource;
  end;

implementation

end.
