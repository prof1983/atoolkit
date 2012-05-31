{**
@Abstract()
@Author(Prof1983 prof1983@ya.ru)
@Created(20.06.2011)
@LastMod(04.07.2011)
@Version(0.5)
}
unit AKernelBase;

interface

uses
  ABase;

var
  APlatformName: string;
  // Базовая версия ядра и модулей
  APlatformVersion: AVersion;
  //APlatformVersion = (APlatformMajorVersion shl 24) or (APlatformMinorVersion shl 16);

implementation

end.
 