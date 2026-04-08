<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Agent Commission Monthly Report</title>
    <style>
        @page {
            size: landscape;
        }

        body {
            font-family: Calibri, sans-serif;
            font-size: 9pt;
            color: black;
            margin: 0;
            padding: 0;
        }

        .header, .footer {
            width: 100%;
            margin-bottom: 20px;
        }

        .header-table {
            width: 50%;
            float: left;
        }

        .logo {
            width: 40%;
            float: right;
            text-align: right;
        }

        .logo img {
            width: 280px;
            height: 80px;
        }

        .clear {
            clear: both;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10pt;
        }

        .data-table th, .data-table td {
            border: 1px solid black;
            padding: 4pt;
        }

        .section-header {
            background-color: #f5f5f5;
            font-weight: bold;
        }

        .text-right {
            text-align: right;
        }

        .text-center {
            text-align: center;
        }

        thead {
            display: table-header-group;
        }

        tr {
            page-break-inside: avoid;
        }
    </style>
</head>
<body>
<div class="header">
    <div class="header-table">
        <table>
            <tr>
                <td style="text-align: left;">Designation:</td>
                <td style="text-align: left; padding-left: 10px;">${agentDesignation}</td>
            </tr>
            <tr>
                <td style="text-align: left;">Commission Payable To:</td>
                <td style="text-align: left; padding-left: 10px;">${agentName}</td>
            </tr>
            <tr>
                <td style="text-align: left;">Commission Statement:</td>
                <td style="text-align: left; padding-left: 10px;">${statementDate}</td>
            </tr>
            <tr>
                <td style="text-align: left;">Pay Date:</td>
                <td style="text-align: left; padding-left: 10px;">${payDate}</td>
            </tr>
        </table>
    </div>
    <div class="logo">
        <img src="https://sgp1.digitaloceanspaces.com/nexstream-dev/citadel/settings/March2025/CitadelWealthPartners.png"
             height="53" width="220" alt="Company Logo"/>
    </div>
    <div class="clear"></div>
</div>

<table class="data-table">
    <thead>
    <tr class="section-header">
        <th style="width:5%; text-align: center">No</th>
        <th style="width:15%; text-align: center">CLOSING DATE</th>
        <th style="width:20%; text-align: center">CLIENT</th>
        <th style="width:20%; text-align: center">AGREEMENT NUMBER</th>
        <th style="width:20%; text-align: center">CONSULTANT</th>
        <th style="width:10%; text-align: center">PURCHASED AMOUNT (MYR)</th>
        <th style="width:5%; text-align: center">COMM %</th>
        <th style="width:5%; text-align: center">COMM.AMOUNT (MYR)</th>
    </tr>
    </thead>
    <tbody>
    <#list productList as product>
        <!-- Product Header -->
        <tr>
            <!-- 1st column (No) is empty -->
            <td></td>
            <!-- 2nd column shows the product code -->
            <td><b><u>${product.productCode}</u></b></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <!-- Personal Sales Section -->
        <tr>
            <!-- 1st column (No) is empty -->
            <td></td>
            <!-- 2nd column text -->
            <td><b><u>PERSONAL SALES</u></b></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <#if product.personalSalesRecords?size == 0>
            <tr>
                <td colspan="7" class="text-center">No Personal Sales Records</td>
            </tr>
        <#else>
            <#list product.personalSalesRecords as pRecord>
                <tr>
                    <td class="text-center">${pRecord.no}</td>
                    <td class="text-center">${pRecord.date}</td>
                    <td>${pRecord.clientName}</td>
                    <td>${pRecord.agreementNumber}</td>
                    <td>${pRecord.consultantName}</td>
                    <td class="text-center">${pRecord.amount}</td>
                    <td class="text-center">${pRecord.commPercent}</td>
                    <td class="text-right">${pRecord.commAmount}</td>
                </tr>
            </#list>
        </#if>
        <!-- Empty Row -->
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="text-right">-</td>
        </tr>
        <!-- Overriding Sales Section -->
        <tr>
            <!-- 1st column (No) is empty -->
            <td></td>
            <!-- 2nd column text -->
            <td><b><u>OVERRIDING</u></b></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <#if product.overrideSalesRecords?size == 0>
            <tr>
                <td colspan="7" class="text-center">No Overriding Sales Records</td>
            </tr>
        <#else>
            <#list product.overrideSalesRecords as oRecord>
                <tr>
                    <td class="text-center">${oRecord.no}</td>
                    <td class="text-center">${oRecord.date}</td>
                    <td>${oRecord.clientName}</td>
                    <td>${oRecord.agreementNumber}</td>
                    <td>${oRecord.consultantName}</td>
                    <td class="text-center">${oRecord.amount}</td>
                    <td class="text-center">${oRecord.commPercent}</td>
                    <td class="text-right">${oRecord.commAmount}</td>
                </tr>
            </#list>
        </#if>
        <!-- Empty Row -->
        <tr>
            <td><p> </p></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td class="text-right">-</td>
        </tr>
    </#list>
    </tbody>
</table>
<br/>
<table class="data-table">
    <tr>
        <td style="width: 50%; text-align: center; border: none; border-top: 2pt solid black; border-bottom: 2pt solid black;"><b>GRAND TOTAL</b></td>
        <td style="width: 50%; text-align: right; border: none; border-top: 2pt solid black; border-bottom: 2pt solid black;"><b>${grandTotal}</b></td>
    </tr>
</table>
<div style="page-break-inside: avoid;">
<table border="1" style="width:40%; margin-top: 10pt; border-collapse: collapse; border: 2px solid black;">
    <tbody>
    <#list productList as product>
        <tr style="page-break-inside: avoid;">
            <!-- 1st column Total Product Commission Text is empty -->
            <td><b>Total ${product.productCode} Comm (RM)</b></td>
            <!-- 2nd column shows the product code -->
            <td class="text-center"><b>${product.productTotalCommission}</b></td>
        </tr>
    </#list>
    </tbody>
</table>
<table border="1" style="width:40%; margin-top: 10pt; border-collapse: collapse; border: 2px solid black;">
    <tr style="page-break-inside: avoid;">
        <td><b>Total Pay Out (RM)</b></td>
        <td class="text-center"><b>${grandTotal}</b></td>
    </tr>
</table>
</div>
<br/>
<p style="font-style: italic;"><b>Note: Payment of Commission will be in your bank 2-3 days after due date.</b></p>
<p style="font-style: italic;"><b>This is a computer generated printout and no signature is required.</b></p>
</body>
</html>
