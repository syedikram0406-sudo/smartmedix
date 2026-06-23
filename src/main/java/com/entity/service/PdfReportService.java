package com.entity.service;

import com.entity.model.LabReport;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.time.format.DateTimeFormatter;

import com.entity.model.Payment;

@Service
public class PdfReportService {

    public byte[] generateReceiptPdf(Payment payment) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4);

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Header
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, Font.BOLD);
            Paragraph title = new Paragraph("Payment Receipt", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);

            // Clinic Info
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
            document.add(new Paragraph("SmartMedix Healthcare", headerFont));
            document.add(new Paragraph("Transaction ID: " + payment.getTransactionId(), headerFont));
            document.add(new Paragraph("Date: " + payment.getPaymentDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")), headerFont));
            document.add(new Paragraph(" ", headerFont));

            // Info Table
            PdfPTable table = new PdfPTable(2);
            table.setWidthPercentage(100);
            table.setSpacingBefore(10);
            table.setSpacingAfter(20);

            table.addCell(getLabelCell("Patient Name:"));
            table.addCell(getValueCell(payment.getBill().getPatient().getName()));

            table.addCell(getLabelCell("Bill Reference:"));
            table.addCell(getValueCell("#BILL-" + payment.getBill().getId()));

            table.addCell(getLabelCell("Service Type:"));
            table.addCell(getValueCell(payment.getBill().getServiceType()));

            table.addCell(getLabelCell("Payment Method:"));
            table.addCell(getValueCell(payment.getPaymentMethod()));

            table.addCell(getLabelCell("Amount Paid:"));
            table.addCell(getValueCell("INR " + payment.getAmountPaid()));

            table.addCell(getLabelCell("Status:"));
            table.addCell(getValueCell(payment.getStatus()));

            document.add(table);

            // Footer
            Paragraph footer = new Paragraph("\n\nThank you for choosing SmartMedix. This is an electronically generated receipt.", FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return out.toByteArray();
    }

    public byte[] generateLabReportPdf(LabReport report) {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        Document document = new Document(PageSize.A4);

        try {
            PdfWriter.getInstance(document, out);
            document.open();

            // Header
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, Font.BOLD);
            Paragraph title = new Paragraph("Medical Lab Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);

            // Clinic Info (Mock)
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA, 12);
            document.add(new Paragraph("HMS Digital Medical Center", headerFont));
            document.add(new Paragraph("123 Healthcare Ave, Medical City", headerFont));
            document.add(new Paragraph("Contact: +1 234 567 890", headerFont));
            document.add(new Paragraph(" ", headerFont));

            // Table for Patient and Report Info
            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);
            infoTable.setSpacingBefore(10);
            infoTable.setSpacingAfter(20);

            infoTable.addCell(getLabelCell("Patient Name:"));
            infoTable.addCell(getValueCell(report.getPatient().getName()));

            infoTable.addCell(getLabelCell("Patient ID:"));
            infoTable.addCell(getValueCell("P" + report.getPatient().getId()));

            infoTable.addCell(getLabelCell("Report Date:"));
            infoTable.addCell(getValueCell(report.getReportDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"))));

            infoTable.addCell(getLabelCell("Test Name:"));
            infoTable.addCell(getValueCell(report.getTestName()));

            document.add(infoTable);

            // Results Section
            Paragraph resultsHeader = new Paragraph("Test Results", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16));
            resultsHeader.setSpacingAfter(10);
            document.add(resultsHeader);

            PdfPTable resultsTable = new PdfPTable(3);
            resultsTable.setWidthPercentage(100);
            resultsTable.addCell(getHeaderCell("Parameter"));
            resultsTable.addCell(getHeaderCell("Result"));
            resultsTable.addCell(getHeaderCell("Normal Range"));

            resultsTable.addCell(getValueCell(report.getTestName()));
            resultsTable.addCell(getValueCell(report.getResult()));
            resultsTable.addCell(getValueCell(report.getNormalRange() != null ? report.getNormalRange() : "N/A"));

            document.add(resultsTable);

            // Remarks
            document.add(new Paragraph(" ", headerFont));
            Paragraph remarks = new Paragraph("Remarks:", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12));
            document.add(remarks);
            document.add(new Paragraph(report.getRemarks() != null ? report.getRemarks() : "No specific remarks.", headerFont));

            // Footer
            Paragraph footer = new Paragraph("\n\nThis is a computer-generated report and does not require a physical signature.", FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
        } catch (DocumentException e) {
            e.printStackTrace();
        }

        return out.toByteArray();
    }

    private PdfPCell getLabelCell(String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(5);
        return cell;
    }

    private PdfPCell getValueCell(String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA, 12)));
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(5);
        return cell;
    }

    private PdfPCell getHeaderCell(String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12)));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setPadding(5);
        return cell;
    }
}
