{**
@Abstract ASystem base
@Author Prof1983 <prof1983@ya.ru>
@Created 24.10.2011
}
unit ASystemBase;

interface

uses
  ABase;

const
  ASystem_Name02 = 'System';
  ASystem_Name03 = 'ASystem';
  ASystem_Name = {$ifdef A02}ASystem_Name02{$else}ASystem_Name03{$endif};
  ASystem_Uid = $07082001;

type
  ATimer = type AInteger;

implementation

end.
 