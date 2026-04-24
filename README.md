# 📊 Trenvo Churn Analysis

## Overview
Trenvo is a subscription-based tech company.  
This project analyzes the relationship between **user acquisition, engagement, and churn**, and how these factors impact overall revenue performance.

## Objective
Identify the primary driver of churn and recommend solutions to improve retention and revenue stability.

---

## 📌 Executive Summary

**Key Insight**  
Churn is driven by **low user engagement**, not acquisition channel — despite similar LTV across channels.

### Core Metrics
- **MRR:** $62.39K  
- **Active Subscribers:** 169K  
- **Avg LTV:** $47.17  

### North Star Metrics
- Revenue Performance  
- Customer Retention  
- User Engagement  

### Root Cause
- **62–68% of users were inactive** prior to cancellation  

### Risk
- Churn increased from **~67% (2023)** to **~85% (2024)**  
- Indicates declining retention and unstable revenue  

---

## 🔍 Deep Dive

### Key Findings
- Most churned users had **0–1 activities** in the 30 days before canceling  
- Pattern is **consistent across all acquisition channels**

### Additional Risk
- Paid and referral channels show slightly higher churn among active users (~1.4%)  
- Suggests **unmet expectations or product gaps**

### Critical Event (June 2024)
- Sharp spike in churn compared to steady growth in June 2023  
- Likely caused by:
  - Product changes  
  - Pricing adjustments  
  - UX issues  

---

## 🚨 Recommendations

### 1. Early User Activation
**Problem:** Users drop off before experiencing product value  

**Actions:**
- Track first 7-day behavior (feature usage, session frequency)  
- Implement onboarding walkthrough  

**Goal:**  
Increase % of users reaching the “value moment” within 7 days  

---

### 2. Engagement Retention System
**Problem:** Users go inactive before churning  

**Actions:**
- Trigger inactivity alerts:
  - 7-day inactive  
  - 14-day inactive  
- Interventions:
  - Email / SMS nudges  
  - Feature reminders  
  - Incentives (discounts, promos)  

**Goal:**  
Reduce pre-churn inactivity  

---

### 3. Investigate Churn Spikes (Feb & June 2024)
**Problem:** Sudden increase in churn  

**Actions:**
- Survey churned active users  
- Identify friction points in product/experience  

**Goal:**  
Retain high-value users and improve LTV  
