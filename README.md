# 🛠️ PowerShell Execution Guide for Windows

<p>This section provides instructions on how to execute PowerShell scripts (.ps1) on a Windows environment.</p>

<hr />

## 🚀 Execution Methods

### 1. Simple Right-Click
<ul>
  <li>Locate your <code>.ps1</code> file in File Explorer.</li>
  <li><b>Right-click</b> the file and select <b>Run with PowerShell</b>.</li>
</ul>

### 2. Execution via Terminal (Recommended)
<p>Open PowerShell and call the script directly. Use quotes and an ampersand if your path contains spaces:</p>

<pre><code>& "C:\Path\To\Your\Script.ps1"</code></pre>

<hr />

## ⚠️ Troubleshooting: Execution Policy
<p>By default, Windows restricts script execution. If you encounter an error regarding <i>"running scripts is disabled,"</i> use one of the following commands to bypass the restriction:</p>

<table>
  <tr>
    <th>Method</th>
    <th>Command</th>
  </tr>
  <tr>
    <td><b>Current Session Only</b></td>
    <td><code>Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process</code></td>
  </tr>
  <tr>
    <td><b>One-Time Run</b></td>
    <td><code>powershell.exe -ExecutionPolicy Bypass -File "YourScript.ps1"</code></td>
  </tr>
</table>

<hr />

## 💡 Quick Tips
<blockquote>
  <b>Admin Rights:</b> If the script fails due to permissions, ensure you are running PowerShell as an <b>Administrator</b>.<br>
  <b>Unblocking Files:</b> If the script was downloaded from the web, right-click the file &gt; <b>Properties</b> &gt; Check <b>Unblock</b> &gt; <b>Apply</b>.
</blockquote>
