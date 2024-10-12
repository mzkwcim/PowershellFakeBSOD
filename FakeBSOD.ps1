Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$targetUrl = "https://www.google.com"
$qrCodePath = "$env:TEMP\qr_code.png"
Invoke-WebRequest -Uri "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$([uri]::EscapeDataString($targetUrl))" -OutFile $qrCodePath

$form = New-Object System.Windows.Forms.Form
$form.WindowState = 'Maximized'
$form.BackColor = 'DarkBlue'
$form.FormBorderStyle = 'None'
$form.TopMost = $true

$label = New-Object System.Windows.Forms.Label
$label.ForeColor = 'White'
$label.Font = New-Object System.Drawing.Font('Consolas', 18, [System.Drawing.FontStyle]::Bold)
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(50, 700)
$label.Text = ":(
    
Twój komputer napotkał problem i należy go uruchomić ponownie.
Zbieramy pewne informacje o błędzie, a następnie uruchomimy go ponownie."

$form.Controls.Add($label)

$qrImage = [System.Drawing.Image]::FromFile($qrCodePath)

$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Image = $qrImage
$pictureBox.SizeMode = 'StretchImage'
$pictureBox.Size = New-Object System.Drawing.Size(150, 150)
$pictureBox.Location = New-Object System.Drawing.Point(50, 850)

$form.Controls.Add($pictureBox)

$qrLabel = New-Object System.Windows.Forms.Label
$qrLabel.ForeColor = 'White'
$qrLabel.Font = New-Object System.Drawing.Font('Consolas', 18, [System.Drawing.FontStyle]::Bold)
$qrLabel.AutoSize = $true
$qrLabel.Location = New-Object System.Drawing.Point(200, 850)
$qrLabel.Text = "Skanuj kod QR, aby uzyskać więcej informacji"

$form.Controls.Add($qrLabel)

$form.ShowDialog()

Remove-Item $qrCodePath
