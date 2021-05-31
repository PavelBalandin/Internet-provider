package org.example.model.service;

import org.example.model.dao.DaoFactory;
import org.example.model.dao.TariffDAO;
import org.example.model.entity.Service;
import org.example.model.entity.Tariff;
import org.example.model.entity.TariffPage;

import java.math.BigDecimal;
import java.util.List;

public class TariffService {

    DaoFactory daoFactory = DaoFactory.getInstance();

    public Tariff getTariffById(int id) {
        try (TariffDAO dao = daoFactory.createTariffDao()) {
            return dao.findById(id);
        }
    }

    public List<Tariff> getAllTariffs() {
        try (TariffDAO dao = daoFactory.createTariffDao()) {
            return dao.findAll();
        }
    }

    public List<Tariff> getTariffsByUserLogin(String login) {
        try (TariffDAO dao = daoFactory.createTariffDao()) {
            return dao.findTariffsByLogin(login);
        }
    }

    public TariffPage getPaginated(int page, int size) {
        try (TariffDAO dao = daoFactory.createTariffDao()) {
            return dao.findPaginated(page, size);
        }
    }

    public List<Tariff> getAllTariffsByServiceId(int id, String sort, String order) {
        try (TariffDAO dao = daoFactory.createTariffDao()) {
            return dao.findAllByServiceId(id, sort, order);
        }
    }

    public void createTariff(String name, String description, String duration, BigDecimal price, int serviceId) {
        Service service = new Service.Builder()
                .withId(serviceId)
                .build();

        Tariff tariff = new Tariff.Builder()
                .withName(name)
                .withDescription(description)
                .withDuration(duration)
                .withPrice(price)
                .withService(service)
                .build();

        try (TariffDAO dao = daoFactory.createTariffDao()) {
            dao.create(tariff);
        }
    }

    public void updateTariff(int id, String name, String description, String duration, BigDecimal price, int serviceId) {
        Service service = new Service.Builder()
                .withId(serviceId)
                .build();

        Tariff tariff = new Tariff.Builder()
                .withId(id)
                .withName(name)
                .withDescription(description)
                .withDuration(duration)
                .withPrice(price)
                .withService(service)
                .build();

        try (TariffDAO dao = daoFactory.createTariffDao()) {
            dao.update(tariff);
        }
    }

    public void deleteTariff(int id) {
        try (TariffDAO dao = daoFactory.createTariffDao()) {
            dao.delete(id);
        }
    }

}
