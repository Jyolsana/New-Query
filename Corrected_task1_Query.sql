--b.	Display the current home value for each property in question a). 

select Property.Name,Property.Id,PropertyHomeValue.Value from dbo.Property inner join OwnerProperty on
OwnerProperty.PropertyId=Property.Id 
inner join dbo.PropertyHomeValue on PropertyHomeValue.PropertyId= Property.Id
where dbo.OwnerProperty.OwnerId = 1426 and dbo.PropertyHomeValue.IsActive=1;



--c.	For each property in question a), return the following:                                                                      
--i.	Using rental payment amount, rental payment frequency, tenant start date and tenant end date to write a query that returns the sum of all payments from start date to end date. 
select 
OwnerProperty.OwnerId,
OwnerProperty.PropertyId,
Property.Name as [Pname],
TenantProperty.PaymentAmount,
TenantProperty.StartDate,
TenantProperty.EndDate,
TenantPaymentFrequencies.Name,
case TenantProperty.PaymentFrequencyId
when 1 then DATEDIFF(week,TenantProperty.StartDate, TenantProperty.EndDate)* TenantProperty.PaymentAmount
when 2 then DATEDIFF(week,TenantProperty.StartDate, TenantProperty.EndDate)/2 * TenantProperty.PaymentAmount
when 3 then DATEDIFF(month,TenantProperty.StartDate, TenantProperty.EndDate) * TenantProperty.PaymentAmount
end TotalPayment
from Property
inner join OwnerProperty on OwnerProperty.PropertyId= Property.Id
inner join TenantProperty on TenantProperty.PropertyId=Property.Id
inner join TenantPaymentFrequencies on TenantPaymentFrequencies.Id= TenantProperty.PaymentFrequencyId
where OwnerProperty.OwnerId=1426;


--d.	Display all the jobs available in the marketplace (jobs that owners have advertised for service suppliers).
select job.ProviderId, job.PropertyId,job.OwnerId, job.JobDescription
from job
inner join ServiceProviderJobStatus on job.JobStatusId=ServiceProviderJobStatus.Id
where ServiceProviderJobStatus.Name='open' And job.OwnerId is not null;

