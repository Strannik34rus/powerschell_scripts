#Генерим входные данные:

#Двумерный массив T1: GRP|SRV

$T1 = 0..10 | ForEach {Return ,@(('GRP_' + (Get-Random ('A'..'Z')) + (Get-Random ('A'..'Z'))),('SRV_' + (Get-Random -Minimum 100 -Maximum 999)))}

#Строки T1 должны быть уникальны и перемешаны:

$T1 = $T1 | Sort-Object -Unique | Sort-Object {Get-Random}

#Двумерный массив T2: SRV|GUID. Массив из уникальных SRV записей с уникальными идентификаторами

$T2 = $T1 | ForEach {$_[1]} | Select -Unique | ForEach {Return ,@(($_),([guid]::NewGuid().Guid))}

#создаём массив T3: GRP|GUID
#$T3 = $T1 | ForEach {$_[0]} | Select -Unique | ForEach {Return ,@(($_),([guid]::NewGuid().Guid))}

